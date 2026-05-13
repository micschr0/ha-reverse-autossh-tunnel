# SSH Reverse Tunnel (autossh) — Documentation

This add-on maintains a persistent SSH reverse tunnel from your Home
Assistant instance to a remote server you control. autossh's monitoring
port detects stalled connections and reconnects automatically; if autossh
itself crashes, s6 restarts the service.

## Prerequisites

- A remote SSH server with a public IP address, on which you have
  administrative access (or at least the ability to add an `authorized_keys`
  entry to a user account dedicated to this tunnel).
- A user on that server (default name: `autossh`).

## Setup

### 1. Configure the add-on

In the add-on configuration tab, set at minimum:

```yaml
hostname: ssh.example.com
ssh_port: 22
username: autossh
remote_ip_address: 127.0.0.1
remote_port: 8123
```

`remote_ip_address: 127.0.0.1` keeps the forwarded port bound to localhost
on the remote server. You then expose it publicly via a reverse proxy or
`GatewayPorts clientspecified` (see "Remote-server patterns" below).

### 2. Start the add-on

The first start will fail to authenticate — that is expected. The add-on
generates an ED25519 keypair and logs the public key:

```
[INFO] Public key — paste this line into ~/.ssh/authorized_keys on the remote server:
[INFO]
[INFO] command="",restrict,port-forwarding,permitopen="127.0.0.1:8123" ssh-ed25519 AAAA... ha-reverse-autossh-tunnel
[INFO]
```

### 3. Authorize the key on the remote server

Copy the entire line (including the `command=...permitopen=...` prefix)
into `~/.ssh/authorized_keys` for the user named in your `username` option.
The restriction prefix limits what this key can do — only port-forwarding
to the specified `remote_ip:remote_port`, no shell, no other forwards.

### 4. Restart the add-on

It should now connect. Verify in the log:

```
[INFO] Starting autossh to autossh@ssh.example.com:22
```

### 5. Trust the tunnel in Home Assistant

Add to your `/config/configuration.yaml`:

```yaml
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 127.0.0.1
    - ::1
```

Restart Home Assistant.

## Options reference

| Option | Type | Default | Description |
|---|---|---|---|
| `hostname` | str | — | DNS name or IP of the remote SSH server. Required. |
| `ssh_port` | port | `22` | Port the remote sshd listens on. |
| `username` | str | `autossh` | User on the remote server. |
| `remote_ip_address` | str | `127.0.0.1` | Interface on the remote to bind the forwarded port. |
| `remote_port` | port | `8123` | Port on the remote to bind to. |
| `local_ip_address` | str? | `homeassistant` | HA host's address as seen from the container. The default (`homeassistant`) works for most installations. Set to `127.0.0.1` only if you run HA without the Supervisor. |
| `local_port` | port? | `remote_port` | HA port. |
| `remote_forwarding` | list[str] | `[]` | Extra `-R` forwards, e.g. `["2222:127.0.0.1:22"]`. |
| `other_ssh_options` | str | `""` | Appended to the autossh/ssh command. Use `-v` for verbose logs. |
| `monitoring_port` | int (0–65535) | `0` | autossh's echo-monitoring port. `0` disables the echo port; connection health relies on `ServerAliveInterval`/`ServerAliveCountMax` plus s6 restart. Set a free TCP port (e.g. `12345`) to enable autossh's active connection check. |
| `force_keygen` | bool | `false` | Generate a new ED25519 keypair on the next start. Resets itself to `false` automatically after the key is created — triggers only once. You will need to re-authorize the new public key on the remote server. |
| `skip_remote_host_checks` | bool | `false` | Skip our `ssh-keyscan` pinning and use `StrictHostKeyChecking=accept-new` instead. Insecure for first-connect MITM; use only for debugging or known-good networks. |

## Remote-server patterns

Three common ways to expose the tunneled port publicly:

### A — `GatewayPorts` in sshd

Edit `/etc/ssh/sshd_config` on the remote:

```
GatewayPorts clientspecified
```

Then set `remote_ip_address: 0.0.0.0` in the add-on. The forwarded port
binds to all interfaces. Use a firewall in front.

### B — Reverse proxy (Caddy)

Keep `remote_ip_address: 127.0.0.1` (the default). Run Caddy on the remote:

```caddy
hass.example.com {
  reverse_proxy 127.0.0.1:8123
}
```

Caddy handles TLS automatically. Same approach works with NGINX or Traefik.

### C — Docker-isolated sshd (recommended)

Run a dedicated sshd container on the remote whose only purpose is to
accept this one key. Even if the key leaks, the blast radius is one
container with no shell access and a single permitted forward.

```yaml
# docker-compose.yml on the remote server
services:
  sshd:
    image: linuxserver/openssh-server:latest
    environment:
      USER_NAME: autossh
      PUBLIC_KEY: 'PASTE the restriction-prefixed line from the add-on log here'
      PASSWORD_ACCESS: 'false'
      SUDO_ACCESS: 'false'
      DOCKER_MODS: linuxserver/mods:openssh-server-ssh-tunnel
    ports:
      - "22022:2222"   # public SSH on a non-default port
      - "8123:8123"    # exposed HA UI; put TLS in front
    restart: unless-stopped
```

The `DOCKER_MODS` value enables `GatewayPorts clientspecified` and
`AllowTcpForwarding yes` in the container's sshd config so the tunnel
can bind to all interfaces inside the container. In the add-on, set:

```yaml
hostname: <your-remote-host>
ssh_port: 22022
username: autossh
remote_ip_address: "0.0.0.0"
remote_port: 8123
```

Put Caddy or another TLS-terminating reverse proxy in front of the
exposed port — `8123` itself stays plain HTTP.

## Troubleshooting

- **"Option \"hostname\" is required"** — set `hostname` in the config.
- **A new key was generated unexpectedly** — `force_keygen` was set to
  `true`. It resets itself automatically, but you need to copy the new
  public key from the log into `authorized_keys` on the remote server.
- **autossh reconnects forever** — the public key is not yet in the
  remote `authorized_keys`. Copy the line from the log.
- **"ssh-keyscan returned no host keys"** — DNS or network failure
  reaching the remote. Verify with `dig` / `ping` from the host.
  As a last resort, set `skip_remote_host_checks: true` (uses
  StrictHostKeyChecking=accept-new instead of failing).
- **HA shows the remote-proxy IP everywhere** — `trusted_proxies` is
  not configured in `configuration.yaml` (see step 5).
