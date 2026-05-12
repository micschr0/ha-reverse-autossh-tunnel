# Security Policy

## Reporting a Vulnerability

Please open a private GitHub Security Advisory at
https://github.com/micschr0/ha-reverse-autossh-tunnel/security/advisories/new
instead of a public issue. We will acknowledge within seven days.

## Scope

In scope:
- Vulnerabilities in the add-on's Bash logic, Dockerfile, or default
  configuration that could compromise the host or the remote SSH server.

Out of scope:
- Misconfiguration on the user's remote SSH server.
- Issues in upstream packages (openssh, autossh, Alpine base image) —
  please report those to their maintainers.

## Recommended hardening

Always restrict the add-on's public key on the remote server with:

    command="",restrict,port-forwarding,permitopen="<remote_ip>:<remote_port>" <key>

The add-on logs this exact line on every start so it is copy-pasteable.
