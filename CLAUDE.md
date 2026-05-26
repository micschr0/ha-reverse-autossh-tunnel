# CLAUDE.md

Repo-specific quirks. Read before editing CI, addon config, or AppArmor.

## Release pipeline

- `release-please` triggers `build.yaml` via `gh workflow run build.yaml -f version=$TAG` (workflow_dispatch). The `release` event is NOT used because `GITHUB_TOKEN`-created releases don't trigger workflows.
- `build.yaml` reads `inputs.version` for the dispatch path; strips leading `v`; falls back to `latest` only when input is empty.
- Manual republish for a missing GHCR tag: `gh workflow run build.yaml -f version=v1.X.Y`.
- `verify-publish` job inspects `docker manifest` for each per-arch tag after push; fails CI if missing.

## Addon config (`autossh/config.yaml`)

- Validated in CI by `tests/test_addon_config.py` against vendored schema at `tests/schemas/config.schema.json` (sourced from `frenck/action-addon-linter`).
- `privileged` is a **list of capabilities**, not a boolean. `privileged: false` is a schema error that makes Supervisor silently drop the repo.
- Don't redundantly set `host_network`/`host_pid`/`host_ipc: false` or `boot: auto` or `startup: application` — those are already the Supervisor defaults; the linter flags them.
- HA Supervisor reads `repository.yaml` + addon `config.yaml` from the **default branch (main)**, not from a version tag. It pulls the docker image at `config.yaml`'s `version` from GHCR.

## AppArmor

- **Intentionally absent.** The previous custom profile (497fbe7) caused repeated startup failures (`/init`, `/package/...preinit`, `/usr/lib/autossh/*.sh` all hit `Permission denied`) because strict per-path rules are fragile against s6-overlay version bumps, and Supervisor doesn't reliably reload profiles on addon update.
- PR #27 removed it. The remaining hardening (Supervisor docker-default seccomp+apparmor + `host_*: false` + capability drops) covers the realistic threat model for a tunneling addon.
- Don't re-add without a concrete threat-model justification. If you must, use the dnsmasq pattern (`file,` + `signal,` + `network,` global, capability allowlist, explicit denies) — not strict per-path rules. After re-adding, users must uninstall+reinstall (or restart Supervisor) since AppArmor profiles aren't reloaded on update.

## CI test layering

- **Smoke** (`smoke` job): sources `keygen.sh` + `tunnel.sh` with **stubbed bashio** (jq reading /data/options.json). Tests script-chain logic and dry-run output format. Fast, deterministic.
- **E2E** (`e2e` job): boots the image under real `/init` for 5s. Asserts no `Permission denied` / `s6-overlay-suexec: fatal` / `exec format error` and that at least one s6 service `successfully started`. Catches AppArmor, chmod, missing files, arch mismatches. Does **not** assert service-chain success because `bashio::config` calls the Supervisor HTTP API and won't fall back to /data/options.json in CI.
- **addon-config** (`addon-config` job): JSON Schema validation of `autossh/config.yaml`.
- **verify-publish** (build.yaml): post-push manifest existence check on GHCR.

## Renovate

- Dependency Dashboard is **disabled** in `renovate.json` because the `RENOVATE_TOKEN` PAT lacks `issues: write`. Don't re-enable without fixing the token scope too.
- Actions are pinned by SHA via `helpers:pinGitHubActionDigests`; `github-actions` group automerges.

## Buildx strictness

- `autossh/Dockerfile` has `# check=error=true;skip=InvalidDefaultArgInFrom`. Every future buildx lint warning fails the build. The benign `InvalidDefaultArgInFrom` (we deliberately have no default for `ARG BUILD_FROM`) is the only exception.

## Merge style

- Default: `gh pr merge <n> --squash --delete-branch` for every PR, including release-please PRs.
