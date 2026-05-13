#!/usr/bin/env bats

setup() {
    load 'helpers/setup'
    _setup_test_env
    _set_option_str remote_ip_address "127.0.0.1"
    _set_option remote_port 8123
    _set_option force_keygen false
}

@test "keygen: generates key when none exists" {
    run autossh::keygen
    [ "$status" -eq 0 ]
    [ -f "$AUTOSSH_DATA_DIR/.ssh/id_ed25519" ]
    [ -f "$AUTOSSH_DATA_DIR/.ssh/id_ed25519.pub" ]
}

@test "keygen: leaves existing key alone when force_keygen=false" {
    echo "stub-private-key" > "$AUTOSSH_DATA_DIR/.ssh/id_ed25519"
    echo "ssh-ed25519 AAAA stub" > "$AUTOSSH_DATA_DIR/.ssh/id_ed25519.pub"
    run autossh::keygen
    [ "$status" -eq 0 ]
    [ "$(cat "$AUTOSSH_DATA_DIR/.ssh/id_ed25519")" = "stub-private-key" ]
}

@test "keygen: regenerates when force_keygen=true" {
    echo "stub-private-key" > "$AUTOSSH_DATA_DIR/.ssh/id_ed25519"
    echo "ssh-ed25519 AAAA stub" > "$AUTOSSH_DATA_DIR/.ssh/id_ed25519.pub"
    _set_option force_keygen true
    run autossh::keygen
    [ "$status" -eq 0 ]
    [ "$(cat "$AUTOSSH_DATA_DIR/.ssh/id_ed25519")" != "stub-private-key" ]
}

@test "keygen: logs public key with restriction template" {
    run autossh::keygen
    [ "$status" -eq 0 ]
    [[ "$output" == *'command="",restrict,port-forwarding,permitlisten="127.0.0.1:8123"'* ]]
    [[ "$output" == *'ssh-ed25519 '* ]]
}

@test "keygen: restriction template uses configured remote endpoint" {
    _set_option_str remote_ip_address "10.0.0.5"
    _set_option remote_port 4443
    run autossh::keygen
    [[ "$output" == *'permitlisten="10.0.0.5:4443"'* ]]
}

@test "keygen: private key is mode 0600" {
    run autossh::keygen
    [ "$status" -eq 0 ]
    [ "$(stat -c %a "$AUTOSSH_DATA_DIR/.ssh/id_ed25519")" = "600" ]
}
