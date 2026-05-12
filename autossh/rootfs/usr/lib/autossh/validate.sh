# shellcheck shell=bash
# autossh::validate — fail-fast on misconfiguration; warn on best-effort checks.

autossh::validate() {
    local hostname
    hostname=$(bashio::config 'hostname')
    if bashio::var.is_empty "$hostname"; then
        bashio::log.fatal 'Option "hostname" is required. Set it in the add-on configuration.'
        return 1
    fi
    if ! [[ "$hostname" =~ ^[a-zA-Z0-9._-]+$ ]]; then
        bashio::log.fatal 'Option "hostname" must be a valid hostname or IP address.'
        return 1
    fi

    local username
    username=$(bashio::config 'username')
    if ! [[ "$username" =~ ^[a-zA-Z_][a-zA-Z0-9_.-]{0,31}$ ]]; then
        bashio::log.fatal 'Option "username" contains invalid characters.'
        return 1
    fi

    if ! curl -sf --max-time 5 -I -H "Authorization: Bearer ${SUPERVISOR_TOKEN:-}" \
            "http://supervisor/core/api/" >/dev/null; then
        bashio::log.warning 'Local Home Assistant API at http://supervisor/core/api/ is not reachable yet — continuing; the tunnel will work once HA is up.'
    fi

    return 0
}
