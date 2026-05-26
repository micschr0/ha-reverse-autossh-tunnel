# Changelog

## [1.4.4](https://github.com/micschr0/ha-reverse-autossh-tunnel/compare/v1.4.3...v1.4.4) (2026-05-26)


### Bug Fixes

* **apparmor:** adopt dnsmasq pattern, restrict via capabilities not paths ([#25](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/25)) ([051bc1e](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/051bc1ece9663b885347e86928433885b86b4039))

## [1.4.3](https://github.com/micschr0/ha-reverse-autossh-tunnel/compare/v1.4.2...v1.4.3) (2026-05-26)


### Bug Fixes

* **apparmor:** grant read on /init and s6 runtime paths ([#23](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/23)) ([abf857a](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/abf857aaa7277aa3b855d4e1b83b1d294a3e468b))

## [1.4.2](https://github.com/micschr0/ha-reverse-autossh-tunnel/compare/v1.4.1...v1.4.2) (2026-05-26)


### Bug Fixes

* **config:** remove invalid privileged: false from addon config ([#20](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/20)) ([6deb37b](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/6deb37bbc7408a334e5ecfeea072b3c110b09d86))

## [1.4.1](https://github.com/micschr0/ha-reverse-autossh-tunnel/compare/v1.4.0...v1.4.1) (2026-05-26)


### Bug Fixes

* **ci:** publish versioned image on release and verify GHCR tag ([#17](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/17)) ([6f50774](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/6f50774172dbe2725dadca1089d3fa5665a2cc98))

## [1.4.0](https://github.com/micschr0/ha-reverse-autossh-tunnel/compare/v1.3.1...v1.4.0) (2026-05-23)


### Features

* **security:** add Grype CVE scan, Syft SBOM, and zizmor workflow audit ([c32427b](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/c32427ba35123081948af756578caeeb60e68518))

## [1.3.1](https://github.com/micschr0/ha-reverse-autossh-tunnel/compare/v1.3.0...v1.3.1) (2026-05-13)


### Bug Fixes

* **ci:** grant actions:write so release-please can dispatch build.yaml ([568b7d6](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/568b7d6f8a85b15931c1273352bfbc90fc075f9e))

## [1.3.0](https://github.com/micschr0/ha-reverse-autossh-tunnel/compare/v1.2.0...v1.3.0) (2026-05-13)


### Features

* **ci:** migrate to home-assistant/builder reusable actions ([cfc219d](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/cfc219d540a0877a8a553afbb61db61cca1f5e3e))
* **security:** harden Dockerfile, config and add AppArmor profile ([#10](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/10)) ([00254a8](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/00254a84237dbc55f7c7b8d2b8924995df26a96a))
* **security:** pin base images by digest and verify cosign signatures ([#11](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/11)) ([dd096b5](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/dd096b597a44fe22716f1aa1fb3c3bb7ea9a7b0c))


### Bug Fixes

* **ci:** fix greedy sed stripping image registry from BUILD_FROM ([2ffd610](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/2ffd610349bde7492ae3be488e613767ca8ba326))
* **ci:** pass BUILD_FROM build-arg from autossh/build.yaml ([cd8534c](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/cd8534c9f1bb930bc34c6d6fbad3d08ace45394a))
* **ci:** set context: autossh for build-image action ([549941a](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/549941a0c0eff9d8b94169238937013dbbaacd77))
* **ci:** trigger Docker build after release-please creates a release ([5fc66a8](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/5fc66a8ffaf0a93089048ba1ddc1fa3159e939a2))

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
