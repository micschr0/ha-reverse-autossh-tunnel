# shellcheck shell=bash
# autossh::tunnel — pin the remote host key and exec autossh in the foreground.

autossh::tunnel() {
    local key_dir="${AUTOSSH_DATA_DIR:-/data}/.ssh"
    local key_file="${key_dir}/id_ed25519"
    local known_hosts="${key_dir}/known_hosts"
    local hostname ssh_port username
    local remote_ip remote_port local_ip local_port
    local monitoring_port other_opts
    local -a args=()

    hostname=$(bashio::config 'hostname')
    ssh_port=$(bashio::config 'ssh_port')
    username=$(bashio::config 'username')
    remote_ip=$(bashio::config 'remote_ip_address')
    remote_port=$(bashio::config 'remote_port')
    monitoring_port=$(bashio::config 'monitoring_port')
    other_opts=$(bashio::config 'other_ssh_options')

    if bashio::config.has_value 'local_ip_address'; then
        local_ip=$(bashio::config 'local_ip_address')
    else
        # Default to the HA Core hostname in the Supervisor network so that
        # host_network is not required for the common use-case.
        local_ip="homeassistant"
    fi
    if bashio::config.has_value 'local_port'; then
        local_port=$(bashio::config 'local_port')
    else
        local_port="$remote_port"
    fi

    local strict_check="yes"
    if bashio::config.true 'skip_remote_host_checks'; then
        strict_check="accept-new"
        bashio::log.warning "skip_remote_host_checks=true: using StrictHostKeyChecking=accept-new (host key trusted on first connect)."
    else
        bashio::log.info "Fetching SSH host key for ${hostname}:${ssh_port}"
        local tmp_scan
        tmp_scan=$(mktemp "${known_hosts}.XXXXXX")
        ssh-keyscan -p "$ssh_port" "$hostname" 2>/dev/null > "$tmp_scan" || true
        if [[ ! -s "$tmp_scan" ]]; then
            rm -f "$tmp_scan"
            bashio::log.fatal "ssh-keyscan returned no host keys for ${hostname}:${ssh_port}. Set skip_remote_host_checks=true to bypass (insecure)."
            return 1
        fi
        if [[ -f "$known_hosts" ]] && ! diff -q "$known_hosts" "$tmp_scan" >/dev/null 2>&1; then
            bashio::log.warning "SSH host key for ${hostname} has changed — verify this is expected!"
        fi
        chmod 600 "$tmp_scan"
        mv "$tmp_scan" "$known_hosts"
    fi

    args=(
        -M "$monitoring_port"
        -N
        -i "$key_file"
        -o "ServerAliveInterval=30"
        -o "ServerAliveCountMax=3"
        -o "StrictHostKeyChecking=${strict_check}"
        -o "UserKnownHostsFile=${known_hosts}"
        -R "${remote_ip}:${remote_port}:${local_ip}:${local_port}"
    )

    local options_file="${HASSIO_OPTIONS_FILE:-/data/options.json}"
    local count entry i
    local fw_re='^(([0-9]{1,3}\.){3}[0-9]{1,3}:)?[0-9]{1,5}:[A-Za-z0-9._-]+:[0-9]{1,5}$'
    count=$(jq -r '.remote_forwarding | length' "$options_file")
    for (( i = 0; i < count; i++ )); do
        entry=$(jq -r ".remote_forwarding[$i]" "$options_file")
        if ! [[ "$entry" =~ $fw_re ]]; then
            bashio::log.fatal "remote_forwarding[$i]: invalid format '${entry}' — expected [bind-ip:]port:host:port"
            return 1
        fi
        args+=(-R "$entry")
    done

    if [[ -n "$other_opts" ]]; then
        if echo "$other_opts" | grep -qiE 'ProxyCommand|LocalCommand|PermitLocalCommand'; then
            bashio::log.fatal "other_ssh_options: ProxyCommand and LocalCommand are forbidden."
            return 1
        fi
        # shellcheck disable=SC2206
        args+=( $other_opts )
    fi

    args+=( "${username}@${hostname}" -p "$ssh_port" )

    if [[ "${AUTOSSH_DRYRUN:-0}" == "1" ]]; then
        echo "autossh ${args[*]}"
        return 0
    fi

    bashio::log.info "Starting autossh to ${username}@${hostname}:${ssh_port}"
    exec autossh "${args[@]}"
}
