# Changelog

All notable changes to this add-on are documented here. The format is
based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and
this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

## [1.0.0] - 2026-05-11

### Added

- Initial release.
- Persistent reverse SSH tunnel via autossh with built-in monitoring port.
- ED25519 keypair auto-generation; log line is copy-pasteable into
  `authorized_keys` with the recommended restriction prefix.
- Host-key pinning via `ssh-keyscan`; `skip_remote_host_checks` falls back to `StrictHostKeyChecking=accept-new` instead of failing closed.
- Multi-arch build (amd64, aarch64, armv7) on `ghcr.io/home-assistant/<arch>-base:3.23`.
- GitHub Actions CI: hadolint, shellcheck, yamllint, BATS, multi-arch
  build, weekly base-image refresh.
- Renovate manages base-image and Action versions.

[Unreleased]: https://github.com/micschr0/ha-reverse-autossh-tunnel/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/micschr0/ha-reverse-autossh-tunnel/releases/tag/v1.0.0
