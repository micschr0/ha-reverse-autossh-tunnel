#!/usr/bin/env bats

setup() {
    load 'helpers/setup'
    _setup_test_env
    _set_option_str hostname "example.com"
    _set_option_str username "autossh"
}

@test "validate: passes with hostname set and HA reachable" {
    echo 0 > "$BATS_TEST_TMPDIR/mock-curl-status"
    run autossh::validate
    [ "$status" -eq 0 ]
}

@test "validate: fatal-exits when hostname is empty" {
    _set_option_str hostname ""
    run autossh::validate
    [ "$status" -ne 0 ]
    [[ "$output" == *'[FATAL]'* ]]
    [[ "$output" == *'hostname'* ]]
}

@test "validate: warns but does not fail when HA is unreachable" {
    echo 7 > "$BATS_TEST_TMPDIR/mock-curl-status"
    run autossh::validate
    [ "$status" -eq 0 ]
    [[ "$output" == *'[WARN]'* ]]
    [[ "$output" == *'Home Assistant'* ]]
}

@test "validate: fatal-exits when hostname contains invalid characters" {
    _set_option_str hostname "bad host!"
    run autossh::validate
    [ "$status" -ne 0 ]
    [[ "$output" == *'[FATAL]'* ]]
    [[ "$output" == *'hostname'* ]]
}

@test "validate: fatal-exits when username contains invalid characters" {
    _set_option_str username "bad user!"
    run autossh::validate
    [ "$status" -ne 0 ]
    [[ "$output" == *'[FATAL]'* ]]
    [[ "$output" == *'username'* ]]
}
