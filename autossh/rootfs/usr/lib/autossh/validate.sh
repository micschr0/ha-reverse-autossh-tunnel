# shellcheck shell=bash
# autossh::validate — fail-fast on misconfiguration; warn on best-effort checks.

autossh::validate() {
    local hostname
    hostname=$(bashio::config 'hostname')
    if bashio::var.is_empty "$hostname"; then
        bashio::log.fatal 'Option "hostname" is required. Set it in the add-on configuration.'
        return 1
    fi

    if ! curl -sf --max-time 5 -I -H "Authorization: Bearer ${SUPERVISOR_TOKEN:-}" \
            "http://supervisor/core/api/" >/dev/null; then
        bashio::log.warning 'Local Home Assistant API at http://supervisor/core/api/ is not reachable yet — continuing; the tunnel will work once HA is up.'
    fi

    return 0
}
