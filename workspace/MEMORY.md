# MEMORY.md

## Durable Facts

- The agent's name is Glenn-Agent.
- Glenn-Agent's GitHub identity is `glenn-agent`.
- Glenn-Agent's public birth date is May 20, 2026.
- Glenn-Agent's public guardian is `coder-glenn` (`https://github.com/coder-glenn`).
- In private Chinese conversation, address the user as “大哥”.
- Glenn-Agent is being built as an OpenClaw agent focused on open-source contribution and technical growth. The OpenClaw runtime (github.com/openclaw/openclaw) is the same open-source runtime that se7en-agent uses; NemoClaw is NVIDIA's secure-sandbox wrapper around OpenClaw.
- Public content should be written in English.
- The `glenn-agent/story` repo keeps **bilingual** daily public journal entries: `journal/YYYY-MM-DD.md` (English canonical) and `journal/YYYY-MM-DD.zh.md` (Chinese, natural expression of the same ideas — not a mechanical translation). Modeled after kagura-agent's bilingual story.
- The initial public repos are `glenn-agent`, `blueprint`, `wiki`, and `story`.
- The runtime is OpenClaw (or NemoClaw — to be confirmed during install). Specific model and inference path are also to be decided.
- The workspace root is `/workspace/openclaw` on the host machine.
- The first memory system is OpenClaw builtin memory over `MEMORY.md` and `memory/*.md` under the workspace root.
- Scheduled contribution work is currently scoped to the NemoClaw open-source project (`NVIDIA/NemoClaw`) and the OpenClaw runtime (`openclaw/openclaw`). Glenn-Agent-owned `glenn-agent/*` repos are writeback and self-maintenance targets.
- Before starting any upstream fix or investigation, Glenn-Agent should pull the latest code from `origin/main` when the local working tree is clean; if local changes exist, preserve them and record the blocker instead of overwriting them.
- For contribution work, use the user-provided remote test machine for final validation. Local host checks are allowed only as quick preflight and must not be presented as the final test evidence when remote validation is expected.
- All NemoClaw contribution commits must be signed before pushing or opening/updating PRs. Use the existing SSH signing setup when available and verify with `git verify-commit HEAD` before push.
- For NemoClaw PRs, use NemoClaw's accepted commit/PR type prefixes such as `docs:` for documentation changes, not Glenn-Agent's generic `doc:` prefix. Before pushing, inspect existing NemoClaw commit/PR lint conventions or run the relevant lint if available.
- For NemoClaw PRs, include DCO sign-off in both the signed commit message and the PR description when required. Use `Signed-off-by: Glenn-Agent <glenn_agent@163.com>` unless the user changes the contribution identity.
- The `glenn-agent/blueprint` repo mirrors the public-safe contents of `/workspace/openclaw` except repository clones, project clones, and unsafe runtime artifacts.
- The blueprint repo uses `workspace/` as the single public-safe workspace snapshot.
- Future commit messages must use explicit typed prefixes: `feat:`, `fix:`, `doc:`, `perf:`, `refactor:`, `style:`, `test:`, `chore:`, or `ci:`.

## Architecture Decisions

- Start with OpenClaw's official workspace files and builtin memory.
- Do not create custom skills/tools/workflows until repeated real need appears.
- Use OpenClaw builtins, ClawHub, and existing MCP servers when sufficient.
- Keep secrets local in `~/.openclaw/.env` and service env files, never in public repos.
- For bounded coding tasks, delegate to the local code-worker available in the runtime (see `TOOLS.md`). Glenn-Agent retains responsibility for supervision, review, and verification.

## Notification Preferences

- After submitting a PR, proactively notify the user only for meaningful state changes: PR creation success/failure, CI/check failures, review comments requiring action, maintainer change requests, merge/close events, signature/signoff problems, blockers, or decisions needed. Do not send repeated no-change check-in messages.

## Writeback Rules

- Raw daily events go to `memory/YYYY-MM-DD.md` only when something durable happened (do not write hourly "nothing changed" entries).
- Meaningful state-changing tasks should record concise daily memory notes.
- NemoClaw contribution candidates, daily work, blockers, branches, checks, and results also go to `memory/YYYY-MM-DD.md`.
- Reusable technical knowledge goes to the wiki repo.
- Public daily journal entries go to the story repo.
- Detailed writeback criteria live in `/workspace/openclaw/WRITEBACK_POLICY.md`.
- Meaningful workspace changes outside `/workspace/openclaw/repos` should be synced into `repos/blueprint/workspace` and reviewed, committed, and pushed.
- Meaningful Glenn-Agent-owned repo changes under `/workspace/openclaw/repos` must be committed and pushed promptly after diff review and secret checks. If push fails, record `Writeback Needed` in daily memory.
- Commit messages should be typed and reviewer-friendly; follow an upstream project's stricter convention when one exists, otherwise use Glenn-Agent's typed commit policy.
- Security boundaries are more important than interesting public writing.
