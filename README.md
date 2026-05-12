# ha-reverse-autossh-tunnel

A Home Assistant add-on that maintains a persistent reverse SSH tunnel
from your local HA instance to a remote SSH server you control, exposing
Home Assistant safely from the outside without depending on a cloud service.

## Install

In Home Assistant, go to **Settings → Add-ons → Add-on Store → ⋮ → Repositories**
and add:

```
https://github.com/micschr0/ha-reverse-autossh-tunnel
```

Or use this one-click button:

[![Open your Home Assistant instance and show the add add-on repository dialog](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fmicschr0%2Fha-reverse-autossh-tunnel)

## Documentation

Full setup walkthrough, options reference, and remote-server patterns:
[autossh/DOCS.md](autossh/DOCS.md).

## Dependency updates

This repo runs Renovate self-hosted via GitHub Actions
([`.github/workflows/renovate.yaml`](.github/workflows/renovate.yaml)),
not via the Mend-hosted Renovate App. To enable it on a fork:

1. Create a fine-grained Personal Access Token scoped to the repo with
   `Contents: read & write` and `Pull requests: read & write`.
2. Add it as repository secret `RENOVATE_TOKEN` in
   *Settings → Secrets and variables → Actions*.
3. The workflow runs daily at 04:00 UTC and on demand via the *Run workflow*
   button. Configuration lives in [`renovate.json`](renovate.json).

## Architectures

amd64, aarch64, armv7. Older architectures (armhf, i386) are not supported.

## License

MIT.
