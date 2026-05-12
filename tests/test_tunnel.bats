#!/usr/bin/env bats

setup() {
    load 'helpers/setup'
    _setup_test_env
    _set_option_str hostname "example.com"
    _set_option ssh_port 22
    _set_option_str username "autossh"
    _set_option_str remote_ip_address "127.0.0.1"
    _set_option remote_port 8123
    _set_option monitoring_port 0
    _set_option_str other_ssh_options ""
    _set_option remote_forwarding '[]'
    _set_option skip_remote_host_checks true
    echo "ssh-ed25519 AAAA fake-host-key" > "$AUTOSSH_DATA_DIR/.ssh/id_ed25519"
}

@test "tunnel: primary -R uses defaults when local_* unset" {
    run autossh::tunnel
    [ "$status" -eq 0 ]
    [[ "$output" == *'-R 127.0.0.1:8123:127.0.0.1:8123'* ]]
}

@test "tunnel: primary -R honors local_ip_address and local_port" {
    _set_option_str local_ip_address "192.168.1.50"
    _set_option local_port 8123
    run autossh::tunnel
    [[ "$output" == *'-R 127.0.0.1:8123:192.168.1.50:8123'* ]]
}

@test "tunnel: appends one -R per remote_forwarding entry in order" {
    _set_option remote_forwarding '["2222:127.0.0.1:22","9999:127.0.0.1:9999"]'
    run autossh::tunnel
    [[ "$output" == *'-R 2222:127.0.0.1:22'* ]]
    [[ "$output" == *'-R 9999:127.0.0.1:9999'* ]]
    local idx_2222 idx_9999
    idx_2222=$(echo "$output" | grep -bo '2222:127.0.0.1:22' | head -1 | cut -d: -f1)
    idx_9999=$(echo "$output" | grep -bo '9999:127.0.0.1:9999' | head -1 | cut -d: -f1)
    [ "$idx_2222" -lt "$idx_9999" ]
}

@test "tunnel: skips ssh-keyscan when skip_remote_host_checks=true" {
    run autossh::tunnel
    [ "$status" -eq 0 ]
    [ ! -s "$AUTOSSH_DATA_DIR/.ssh/known_hosts" ]
}

@test "tunnel: runs ssh-keyscan when skip_remote_host_checks=false" {
    _set_option skip_remote_host_checks false
    echo "example.com ssh-ed25519 AAAA fake-remote-host-key" > "$BATS_TEST_TMPDIR/mock-keyscan-output"
    run autossh::tunnel
    [ "$status" -eq 0 ]
    grep -q "fake-remote-host-key" "$AUTOSSH_DATA_DIR/.ssh/known_hosts"
}

@test "tunnel: fatal-exits when ssh-keyscan returns empty" {
    _set_option skip_remote_host_checks false
    : > "$BATS_TEST_TMPDIR/mock-keyscan-output"
    run autossh::tunnel
    [ "$status" -ne 0 ]
    [[ "$output" == *'[FATAL]'* ]]
    [[ "$output" == *'ssh-keyscan'* ]]
}

@test "tunnel: emits StrictHostKeyChecking=accept-new when skip_remote_host_checks=true" {
    run autossh::tunnel
    [[ "$output" == *'StrictHostKeyChecking=accept-new'* ]]
}

@test "tunnel: emits keep-alive options" {
    run autossh::tunnel
    [[ "$output" == *'ServerAliveInterval=30'* ]]
    [[ "$output" == *'ServerAliveCountMax=3'* ]]
}

@test "tunnel: emits StrictHostKeyChecking=yes when skip_remote_host_checks=false" {
    _set_option skip_remote_host_checks false
    echo "example.com ssh-ed25519 AAAA fake-remote-host-key" > "$BATS_TEST_TMPDIR/mock-keyscan-output"
    run autossh::tunnel
    [ "$status" -eq 0 ]
    [[ "$output" == *'StrictHostKeyChecking=yes'* ]]
}

@test "tunnel: emits -M with monitoring_port value" {
    _set_option monitoring_port 12345
    run autossh::tunnel
    [[ "$output" == *'-M 12345'* ]]
}

@test "tunnel: passes user@hostname and -p ssh_port" {
    _set_option ssh_port 2200
    run autossh::tunnel
    [[ "$output" == *'autossh@example.com'* ]]
    [[ "$output" == *'-p 2200'* ]]
}

@test "tunnel: appends other_ssh_options verbatim" {
    _set_option_str other_ssh_options "-v -o ConnectTimeout=10"
    run autossh::tunnel
    [[ "$output" == *'-v -o ConnectTimeout=10'* ]]
}
