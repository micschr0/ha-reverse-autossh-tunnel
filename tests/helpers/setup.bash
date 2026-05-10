# shellcheck shell=bash
_setup_test_env() {
    export HASSIO_OPTIONS_FILE="$BATS_TEST_TMPDIR/options.json"
    export AUTOSSH_DATA_DIR="$BATS_TEST_TMPDIR/data"
    export PATH="$BATS_TEST_DIRNAME/helpers/bin:$PATH"
    export AUTOSSH_DRYRUN=1

    echo '{}' > "$HASSIO_OPTIONS_FILE"
    mkdir -p "$AUTOSSH_DATA_DIR/.ssh"
    : > "$BATS_TEST_TMPDIR/mock-autossh-args"
    : > "$BATS_TEST_TMPDIR/mock-keyscan-output"
    : > "$BATS_TEST_TMPDIR/mock-curl-status"

    # shellcheck source=helpers/bashio.sh
    source "$BATS_TEST_DIRNAME/helpers/bashio.sh"

    local lib="$BATS_TEST_DIRNAME/../autossh/rootfs/usr/lib/autossh"
    # Sources are conditional so TDD red-phase (tests written before
    # their target lib exists) fails with the expected "command not
    # found", not "No such file or directory".
    # shellcheck source=../autossh/rootfs/usr/lib/autossh/validate.sh
    [[ -f "$lib/validate.sh" ]] && source "$lib/validate.sh" || true
    # shellcheck source=../autossh/rootfs/usr/lib/autossh/keygen.sh
    [[ -f "$lib/keygen.sh"   ]] && source "$lib/keygen.sh"   || true
    # shellcheck source=../autossh/rootfs/usr/lib/autossh/tunnel.sh
    [[ -f "$lib/tunnel.sh"   ]] && source "$lib/tunnel.sh"   || true
}

_set_option() {
    local key="$1" value="$2"
    jq --arg k "$key" --argjson v "$value" '.[$k] = $v' \
        "$HASSIO_OPTIONS_FILE" > "$HASSIO_OPTIONS_FILE.tmp"
    mv "$HASSIO_OPTIONS_FILE.tmp" "$HASSIO_OPTIONS_FILE"
}

_set_option_str() {
    local key="$1" value="$2"
    jq --arg k "$key" --arg v "$value" '.[$k] = $v' \
        "$HASSIO_OPTIONS_FILE" > "$HASSIO_OPTIONS_FILE.tmp"
    mv "$HASSIO_OPTIONS_FILE.tmp" "$HASSIO_OPTIONS_FILE"
}
