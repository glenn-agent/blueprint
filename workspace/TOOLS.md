# TOOLS.md

This file records setup-specific notes. It must not contain secrets.

## Runtime

- Runtime: **OpenClaw** v2026.5.18 (open-source, `github.com/openclaw/openclaw`) running as user `glennz` on Linux 6.8 (Ubuntu 24.04)
- OpenClaw state root: `~/.openclaw/` (config, plugins, logs, devices, agent sessions)
- Workspace: `/workspace/openclaw` (registered as `agents.defaults.workspace`)
- Gateway: local loopback, `http://127.0.0.1:18789/` (WebSocket + HTTP dashboard), token auth, bind loopback
- Node.js: v24.15.0 (via nvm at `~/.nvm/versions/node/v24.15.0`)
- Upstream provider: NVIDIA Inference API at `https://inference-api.nvidia.com` (OpenAI-compatible)
- Model provider id (OpenClaw config): `nv` (custom provider, OpenAI compatibility mode)
- Default model: `nv/openai/openai/gpt-5.5` (128k context)
- API key location: `~/.openclaw/.env` as `NV_API_KEY=...`. NEVER inline in any markdown, commit, log, chat, or share channel. If a key ever leaks, rotate immediately before anything else.

## Local Secret Files

Recommended local-only files (chmod 600):

```text
~/.openclaw/.env              # NV_API_KEY, GH_TOKEN, etc.
~/.openclaw/gateway.systemd.env  # if running OpenClaw gateway as a service
```

Set permissions:

```bash
chmod 700 ~/.openclaw
chmod 600 ~/.openclaw/.env ~/.openclaw/gateway.systemd.env
```

## Repositories

Public repositories planned for Glenn:

- `glenn-agent/glenn-agent`
- `glenn-agent/blueprint`
- `glenn-agent/wiki`
- `glenn-agent/story`

Local clones should live under:

```text
/workspace/openclaw/repos/
```

Planned clones:

- Profile: `/workspace/openclaw/repos/profile`
- Blueprint: `/workspace/openclaw/repos/blueprint`
- Wiki: `/workspace/openclaw/repos/wiki`
- Story: `/workspace/openclaw/repos/story`

## Projects

Current open-source contribution projects:

- NemoClaw upstream: `/workspace/openclaw/projects/nemoclaw/upstream` (`NVIDIA/NemoClaw`)
- OpenClaw upstream: `/workspace/openclaw/projects/openclaw/upstream` (`openclaw/openclaw`)

Glenn dogfoods both projects — running on OpenClaw makes lessons from OpenClaw contribution work feed back into Glenn's own runtime.

## Code Worker

For bounded code edits, Glenn uses the OpenClaw agent loop directly — no separate worker process at birth.

If `command -v codex` succeeds (`codex-cli 0.130.0` or later), Glenn may delegate bounded edits with:

```bash
codex exec --cd <repo> --sandbox workspace-write --ask-for-approval never "<bounded implementation prompt>"
```

Codex should make the scoped code change and run relevant local checks. Glenn reviews the resulting diff, runs or confirms tests, scans for secrets, and handles commits, pushes, and PR preparation.

Codex delegation is optional. Direct OpenClaw editing is fine when the scope is small and clear.

## Scheduled Jobs

To be configured. OpenClaw supports a native cron-style scheduler. Planned jobs:

- `daily-contribution` — scan and prepare one small upstream candidate per day
- `daily-blueprint-sync` — push public-safe workspace snapshot to `glenn-agent/blueprint`
- `periodic-writeback-review` — review recent memory and decide what to promote to wiki/story/profile

Exact cadence and timezone will be recorded here once chosen. Light heartbeats by default — see `HEARTBEAT.md`.

## Writeback Targets

- Writeback review policy: `/workspace/openclaw/WRITEBACK_POLICY.md`
- Daily raw memory: `/workspace/openclaw/memory/YYYY-MM-DD.md`
- Curated long-term memory: `/workspace/openclaw/MEMORY.md`
- Contribution daily record: `/workspace/openclaw/memory/YYYY-MM-DD.md`
- Public-safe workspace snapshot: `/workspace/openclaw/repos/blueprint/workspace`
- Workspace sync command: `/workspace/openclaw/repos/blueprint/scripts/sync-workspace.sh`
- Reusable technical knowledge: `/workspace/openclaw/repos/wiki`
- Public journey and retrospectives: `/workspace/openclaw/repos/story`

## External CLI Dependencies

- `node` — 24 recommended, 22.19+ minimum (for OpenClaw)
- `git` — required
- `gh` (GitHub CLI) — **not yet installed** on host; required for repo creation, push, and upstream PR work. Install + `gh auth login` before Phase 2
- `rsync` — required by the blueprint sync script
- `codex` — optional code worker (`codex-cli 0.130.0`+)

## Install Status

- ✅ Node 24.15.0 installed via nvm
- ✅ OpenClaw 2026.5.18 installed as global npm package
- ✅ Workspace registered at `/workspace/openclaw`
- ✅ Gateway running on `http://127.0.0.1:18789` (loopback)
- ✅ NV inference provider configured, default model `nv/openai/openai/gpt-5.5`, hello-world model call verified
- ✅ Glenn's first journal written at `memory/2026-05-20.md`
- ⏳ Cron jobs registered (file ready under `cron/`, registration pending admin-scope approval via dashboard)
- ⏳ Public GitHub repos not yet created (needs `gh auth login` + `scripts/bootstrap-public-repos.sh`)
- ⏳ Daemon (systemd user service) not installed (gateway currently runs in foreground via `openclaw gateway run`)
