# Changelog

## 1.1.1 (2026-05-12)

No user-facing changes. Internal CI and dependency-management fixes only.

## 1.1.0 (2026-05-12)

### Security

- **Input validation:** `hostname` and `username` are now validated against a strict
  character allowlist. Invalid values cause a fatal error before the tunnel starts.
- **`other_ssh_options`:** `ProxyCommand` and `LocalCommand` are now explicitly
  blocked to prevent client-side command execution via SSH options.
- **`remote_forwarding`:** Each entry is validated against a strict
  `[bind-ip:]port:host:port` format. Malformed entries cause a fatal error.
- **Host key pinning:** `known_hosts` is now written atomically (temp file → rename).
  A warning is logged if the host key changes between restarts.
- **Permissions:** The shell library scripts (`validate.sh`, `keygen.sh`,
  `tunnel.sh`) are now `644` instead of `755` — they are sourced, not executed.

### Changes

- **`host_network` removed** (`false` by default). The tunnel no longer requires
  host-network access. The default tunnel target is now the `homeassistant` hostname
  available inside the HA Supervisor network.

  **Migration:** If you previously relied on `local_ip_address: 127.0.0.1`
  (the old implicit default) to reach Home Assistant, set
  `local_ip_address: homeassistant` explicitly, or leave `local_ip_address` unset
  — the new default already points to `homeassistant`.

- Base images updated to `ghcr.io/home-assistant/{arch}-base:3.23-2026.04.0`.
- `armv7` support dropped — no Alpine 3.23 base image available for this architecture.

## 1.0.0 (2026-05-11)

Initial release.

- Persistent reverse SSH tunnel via autossh with keep-alive monitoring.
- ED25519 keypair auto-generation; log line is ready to paste into
  `authorized_keys` with the recommended `restrict,port-forwarding,permitopen`
  restriction prefix.
- Host-key pinning via `ssh-keyscan` by default; `skip_remote_host_checks`
  falls back to `StrictHostKeyChecking=accept-new`.
- Supports amd64 and aarch64.
