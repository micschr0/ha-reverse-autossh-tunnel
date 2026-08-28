# Changelog

## [1.5.0](https://github.com/micschr0/ha-reverse-autossh-tunnel/compare/v1.4.7...v1.5.0) (2026-08-28)


### Features

* **ci:** migrate to home-assistant/builder reusable actions ([02e5fc3](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/02e5fc3d8eb9bb32019f21810f8108860ea1fa4a))
* improve UX, security and robustness ([f18dd5d](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/f18dd5dbc5ff8ffe2d0c7602dc833600abf71370))
* initial commit ([996fa4a](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/996fa4ad373360a3fd1ff91d3c269b578a0aa65b))
* **keygen:** auto-reset force_keygen to false after key generation ([c4b4b27](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/c4b4b27342ba9cb2bc010e559103c33a8cffd57b))
* **security:** add Grype CVE scan, Syft SBOM, and zizmor workflow audit ([c32427b](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/c32427ba35123081948af756578caeeb60e68518))
* **security:** harden Dockerfile, config and add AppArmor profile ([#10](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/10)) ([497fbe7](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/497fbe79be8529ed54c83b660f739ed0ec45a372))
* **security:** pin base images by digest and verify cosign signatures ([#11](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/11)) ([8bc6c9d](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/8bc6c9dedbc38e168fbed9e9fd5bb9c31cb4bf74))


### Bug Fixes

* **apparmor:** adopt dnsmasq pattern, restrict via capabilities not paths ([#25](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/25)) ([051bc1e](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/051bc1ece9663b885347e86928433885b86b4039))
* **apparmor:** grant read on /init and s6 runtime paths ([#23](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/23)) ([abf857a](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/abf857aaa7277aa3b855d4e1b83b1d294a3e468b))
* **apparmor:** remove custom profile, rely on Supervisor defaults ([#27](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/27)) ([7009236](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/70092362449cb029584ed1795a46db4d1c09adfe))
* **build:** bump base image to Alpine 3.24 to clear critical curl CVEs ([#45](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/45)) ([2e19239](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/2e19239899d635ed8bfed853fc4014294a4c36e1))
* **ci:** add image field to config.yaml; suppress hadolint DL3006 for HA base image pattern ([2cff1f3](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/2cff1f3d76992c2a166cc69b40d41916f512798e))
* **ci:** fix greedy sed stripping image registry from BUILD_FROM ([6cb1821](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/6cb18210642d93c27f3a872c405a55617bfcd376))
* **ci:** grant actions:write so release-please can dispatch build.yaml ([64d51df](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/64d51df77720ec55a36e4c5af74ab50450f384d7))
* **ci:** mock bashio in smoke test — real bashio requires Supervisor API in CI ([b106153](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/b106153df94356a16086eeb42924619bbd1039fd))
* **ci:** move hadolint ignore to FROM line; drop armv7 (no base image at Alpine 3.23) ([c7d93d1](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/c7d93d10fa6ded6bc4207b2260171f1a675f86bf))
* **ci:** pass BUILD_FROM build-arg from autossh/build.yaml ([94f8895](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/94f88950a1c5687061e102df7fe8a0f03be42b9b))
* **ci:** publish versioned image on release and verify GHCR tag ([#17](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/17)) ([6f50774](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/6f50774172dbe2725dadca1089d3fa5665a2cc98))
* **ci:** repair failing BATS tests and harden Renovate config ([ea68fd0](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/ea68fd0ffe799de4ca1078d05274f0dcd0914aa1))
* **ci:** set context: autossh for build-image action ([993145b](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/993145b4fab6b15b09318fe95b56fe68b35caaaa))
* **ci:** trigger Docker build after release-please creates a release ([aaed7a8](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/aaed7a852fa3c00ea480e12ff85e2a3c04c13d3d))
* **ci:** use full version tag for renovatebot/github-action (v46.1.14) ([9764c71](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/9764c7182fde810e834c1de565784b44eac57aeb))
* **config:** remove invalid privileged: false from addon config ([#20](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/20)) ([6deb37b](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/6deb37bbc7408a334e5ecfeea072b3c110b09d86))
* **docker:** consolidate apk upgrade + add into single RUN ([1b0bd05](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/1b0bd05951a14e210256d783c6d71e2ec2665499))
* **renovate:** add autodiscover + repo filter; drop deprecated packageRule ([9925197](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/9925197f8189e91c9f24d3ddd8cb6678adeb5a76))
* **renovate:** correct permission input name, grant issues:write ([#43](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/43)) ([1bbbe52](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/1bbbe521f7265697aa231b811c88efc673cfb86a))
* **renovate:** enable dashboard, remove schedule, fix push path, add write perms ([cfa0556](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/cfa05569225ed7cc50711484286e9706471c4847))
* **renovate:** move autodiscover settings from repo config to workflow env vars ([7b5969e](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/7b5969e8d53978f1be4776c462669b85568afe55))
* **security:** address CRITICAL/HIGH/MEDIUM findings from security audit ([4a37c4f](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/4a37c4fd2f6e45d7d3cec941a5043e9fe0bec3e3))
* **security:** apk upgrade + grype ignore for base image Go CVEs ([87e773f](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/87e773ff491b4e1103f0af43f0a4ff10258c004c))
* **security:** comprehensive grype ignore for base-image Go CVEs ([1e2cfd4](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/1e2cfd4507e174d247c7ad07c641a56baf53afc5))
* **tunnel:** allow hostname/wildcard as bind address in remote_forwarding ([83c5aea](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/83c5aeab9e0b2eda81225b3eebbe6c76732d9964))
* use RENOVATE_REPOSITORIES, drop autodiscover, add ONBOARDING ([e9d83c4](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/e9d83c4064a0a4cfd159d3dfe4df883ef969de23))

## [1.4.7](https://github.com/micschr0/ha-reverse-autossh-tunnel/compare/v1.4.6...v1.4.7) (2026-08-05)


### Bug Fixes

* **build:** bump base image to Alpine 3.24 to clear critical curl CVEs ([#45](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/45)) ([2e19239](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/2e19239899d635ed8bfed853fc4014294a4c36e1))
* **renovate:** correct permission input name, grant issues:write ([#43](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/43)) ([1bbbe52](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/1bbbe521f7265697aa231b811c88efc673cfb86a))
* use RENOVATE_REPOSITORIES, drop autodiscover, add ONBOARDING ([e9d83c4](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/e9d83c4064a0a4cfd159d3dfe4df883ef969de23))

## [1.4.6](https://github.com/micschr0/ha-reverse-autossh-tunnel/compare/v1.4.5...v1.4.6) (2026-06-26)


### Bug Fixes

* **docker:** consolidate apk upgrade + add into single RUN ([1b0bd05](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/1b0bd05951a14e210256d783c6d71e2ec2665499))
* **renovate:** enable dashboard, remove schedule, fix push path, add write perms ([cfa0556](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/cfa05569225ed7cc50711484286e9706471c4847))
* **security:** apk upgrade + grype ignore for base image Go CVEs ([87e773f](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/87e773ff491b4e1103f0af43f0a4ff10258c004c))
* **security:** comprehensive grype ignore for base-image Go CVEs ([1e2cfd4](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/1e2cfd4507e174d247c7ad07c641a56baf53afc5))

## [1.4.5](https://github.com/micschr0/ha-reverse-autossh-tunnel/compare/v1.4.4...v1.4.5) (2026-05-26)


### Bug Fixes

* **apparmor:** remove custom profile, rely on Supervisor defaults ([#27](https://github.com/micschr0/ha-reverse-autossh-tunnel/issues/27)) ([7009236](https://github.com/micschr0/ha-reverse-autossh-tunnel/commit/70092362449cb029584ed1795a46db4d1c09adfe))

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
