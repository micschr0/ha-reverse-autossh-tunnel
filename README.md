# ha-reverse-autossh-tunnel

A Home Assistant add-on that maintains a persistent reverse SSH tunnel
from your local HA instance to a remote SSH server you control, exposing
Home Assistant safely from the outside without depending on a cloud service.

Built as a hardened rebuild of
[ThomDietrich/home-assistant-addons/autossh](https://github.com/ThomDietrich/home-assistant-addons/tree/master/autossh)
with stricter security defaults, autossh-based health monitoring, current
base images, and CI-driven rebuilds.

## Install

In Home Assistant, go to **Settings → Add-ons → Add-on Store → ⋮ → Repositories**
and add:

```
https://github.com/REPLACE_OWNER/ha-reverse-autossh-tunnel
```

Or use this one-click button:

[![Open your Home Assistant instance and show the add add-on repository dialog](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FREPLACE_OWNER%2Fha-reverse-autossh-tunnel)

## Documentation

Full setup walkthrough, options reference, and remote-server patterns:
[autossh/DOCS.md](autossh/DOCS.md).

## Architectures

amd64, aarch64, armv7. Older architectures (armhf, i386) are not supported.

## License

MIT.
