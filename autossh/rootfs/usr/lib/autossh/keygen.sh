# shellcheck shell=bash
# autossh::keygen — generate/persist the ED25519 key and log the
# public key with the recommended authorized_keys restriction line.

autossh::keygen() {
    local key_dir="${AUTOSSH_DATA_DIR:-/data}/.ssh"
    local key_file="${key_dir}/id_ed25519"
    local remote_ip remote_port pubkey

    mkdir -p "$key_dir"
    chmod 700 "$key_dir"

    if [[ -f "$key_file" ]] && ! bashio::config.true 'force_keygen'; then
        bashio::log.info "Re-using existing SSH key at ${key_file}"
    else
        bashio::log.info "Generating new ED25519 SSH key at ${key_file}"
        rm -f "$key_file" "${key_file}.pub"
        ssh-keygen -t ed25519 -N "" -f "$key_file" -C "ha-reverse-autossh-tunnel" >/dev/null
    fi

    chmod 600 "$key_file"

    remote_ip=$(bashio::config 'remote_ip_address')
    remote_port=$(bashio::config 'remote_port')
    pubkey=$(cat "${key_file}.pub")

    bashio::log.info "Public key — paste this line into ~/.ssh/authorized_keys on the remote server:"
    bashio::log.info ''
    bashio::log.info "command=\"\",restrict,port-forwarding,permitopen=\"${remote_ip}:${remote_port}\" ${pubkey}"
    bashio::log.info ''
}
