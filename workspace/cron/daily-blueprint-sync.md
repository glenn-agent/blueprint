# Daily Blueprint Workspace Sync

You are Glenn-Agent running the daily blueprint workspace sync routine.

Goal:

- Keep `glenn-agent/blueprint` synced with the public-safe contents of `/workspace/openclaw`.
- This job is dedicated to blueprint sync. Do not inspect or modify upstream contribution code unless needed to avoid overwriting local changes.

Scope:

- Source workspace: `/workspace/openclaw`
- Blueprint repo: `/workspace/openclaw/repos/blueprint` (`glenn-agent/blueprint`)
- Sync command: `/workspace/openclaw/repos/blueprint/scripts/sync-workspace.sh`

Required exclusions (must not appear in the published snapshot):

- `/workspace/openclaw/repos` (the local clones themselves)
- `/workspace/openclaw/projects` (upstream project clones)
- `/workspace/openclaw/memory/.dreams` (if such a private memory area exists)
- Git metadata, SQLite databases, local env files, credentials, tokens, private endpoints, secrets

Routine:

1. Read `/workspace/openclaw/AGENTS.md`, `/workspace/openclaw/MEMORY.md`, `/workspace/openclaw/WRITEBACK_POLICY.md`, and `/workspace/openclaw/repos/blueprint/workspace-sync.md` (if it exists).
2. Check blueprint status with `git -C /workspace/openclaw/repos/blueprint status --short --branch`.
3. If blueprint has unrelated local changes before sync, inspect them and preserve them. Do not overwrite operator changes.
4. Run `/workspace/openclaw/repos/blueprint/scripts/sync-workspace.sh`.
5. Check the resulting blueprint diff.
6. Run a secret scan over `/workspace/openclaw/repos/blueprint`, excluding `.git`. Greps to run: `grep -rE '(api[_-]?key|token|secret|password|Bearer\s+[A-Za-z0-9_-]{20,}|sk-[A-Za-z0-9_-]{20,})' /workspace/openclaw/repos/blueprint --exclude-dir=.git || true`
7. Confirm excluded paths are absent from `/workspace/openclaw/repos/blueprint/workspace`.
8. If there are no blueprint changes after sync, **do not commit and do not write a memory entry** — silent no-op.
9. If there are safe blueprint changes, commit them with a concise typed message that follows the Commit Message Policy in `AGENTS.md`, then push `main` to `origin`.
10. Do not add a final-answer writeback block. Routine blueprint syncs usually do not update wiki or story unless the sync captured an operating-model change or public milestone; the scheduled writeback review job handles broader promotion.
11. If commit or push fails, add a `Writeback Needed` entry to the current daily memory file with the repo, branch, reason, and next action.

Final response should include:

- Whether sync produced changes.
- Secret-scan result.
- Commit SHA if committed.
- Push status or blocker.
- Any immediate wiki/story update, if one was clearly required.
