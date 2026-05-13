# Changelog

## [1.2.0](https://github.com/micschr0/ha-reverse-autossh-tunnel/compare/v1.1.2...v1.2.0) (2026-05-13)


### Features

* improve UX, security and robustness ([87d7639](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/87d76399706637bd68b76c2f1cb37c5e6f6d7988))
* **keygen:** auto-reset force_keygen to false after key generation ([17ab29c](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/17ab29cab4d3830b44d36024ed4f84809eadcb8e))


### Bug Fixes

* **ci:** repair failing BATS tests and harden Renovate config ([cf00a61](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/cf00a61f727b2ea1d55527eab51f622753b923c1))

## [1.1.2](https://github.com/micschr0/ha-reverse-autossh-tunnel/compare/v1.1.1...v1.1.2) (2026-05-12)


### Bug Fixes

* **tunnel:** allow hostname/wildcard as bind address in remote_forwarding ([0714181](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/0714181d6eb79df628170af47fd7afac1ac474ce))

## [1.1.1](https://github.com/micschr0/ha-reverse-autossh-tunnel/compare/v1.1.0...v1.1.1) (2026-05-12)


### Bug Fixes

* **ci:** mock bashio in smoke test — real bashio requires Supervisor API in CI ([15183c3](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/15183c3bc7542889f71e15c35312873900c95b07))
* **renovate:** add autodiscover + repo filter; drop deprecated packageRule ([046d7dc](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/046d7dc3e119ba775f6c0461605acdb6a083d1d7))
* **renovate:** move autodiscover settings from repo config to workflow env vars ([b3b78d6](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/b3b78d6a85825ed8613fef0bf4863463c379c498))

## [1.1.0](https://github.com/micschr0/ha-reverse-autossh-tunnel/compare/v1.0.0...v1.1.0) (2026-05-12)


### Features

* initial commit ([6435aa4](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/6435aa4c9f9c024f0ae0a68c37fe93ccec5f57af))


### Bug Fixes

* **ci:** add image field to config.yaml; suppress hadolint DL3006 for HA base image pattern ([36dd8f3](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/36dd8f3b5b0a80764e37a04bc5d50d4c06e3dc72))
* **ci:** move hadolint ignore to FROM line; drop armv7 (no base image at Alpine 3.23) ([94e9ac5](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/94e9ac5ef7a30937fce28cf7752fa01bb5f61956))
* **ci:** use full version tag for renovatebot/github-action (v46.1.14) ([33f1e15](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/33f1e15ce2010cc38305e93dc6c1646dfeb66386))
* **security:** address CRITICAL/HIGH/MEDIUM findings from security audit ([89665b2](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/89665b27e0594f2827d00950d97ec4c590c74776))
