# Contribution Pipeline

This file defines Glenn's current contribution loop.

## Scope

Active contribution projects (both — Glenn dogfoods OpenClaw and contributes to NemoClaw):

- `/workspace/openclaw/projects/openclaw/upstream` -> `openclaw/openclaw` (the runtime Glenn itself runs on)
- `/workspace/openclaw/projects/nemoclaw/upstream` -> `NVIDIA/NemoClaw` (NVIDIA's secure-sandbox wrapper around OpenClaw)

Glenn-owned writeback repositories:

- `/workspace/openclaw/repos/profile` -> `glenn-agent/glenn-agent`
- `/workspace/openclaw/repos/blueprint` -> `glenn-agent/blueprint`
- `/workspace/openclaw/repos/wiki` -> `glenn-agent/wiki`
- `/workspace/openclaw/repos/story` -> `glenn-agent/story`

Do not scan, start, submit, or modify unrelated contribution projects during scheduled jobs unless the user explicitly changes the focus. The Glenn-owned repos are for self-maintenance and writeback, not the primary contribution target.

## Daily Loop

1. Check the active project repo and Glenn-owned writeback repos for local changes before pulling.
2. Before starting any NemoClaw fix or investigation, fetch/pull the active NemoClaw repo from `origin/main` when the working tree is clean. If local changes exist, preserve them and record the blocker instead of overwriting them.
3. Update other clean repos from `origin/main`.
4. Inspect NemoClaw issues, docs, tests, recent commits, and local TODOs.
5. Choose at most one small candidate for the day.
6. Prefer documentation, tests, clear bug fixes, developer tooling, and durable knowledge updates.
7. If the candidate is safe and verifiable, create a topic branch.
8. For code implementation, delegate bounded edits to the local code-worker (see `TOOLS.md`) when available. Otherwise implement directly.
9. Review worker or direct edits with `git diff`, then run the relevant checks.
10. Open or prepare a PR only when the change is clear, tested, and scoped.
11. Record progress in today's daily memory file: `/workspace/openclaw/memory/YYYY-MM-DD.md`.
12. Add immediate wiki/story/profile/blueprint writeback only when clearly required.
13. Otherwise, let the scheduled writeback review job promote durable lessons to public surfaces.
14. If any workspace file changed outside `/workspace/openclaw/repos`, run `/workspace/openclaw/repos/blueprint/scripts/sync-workspace.sh` so `glenn-agent/blueprint` mirrors the public-safe workspace snapshot.
15. Commit and push any changed Glenn-owned writeback repo after diff review and secret checks.

## Date Organization

- Use `/workspace/openclaw/memory/YYYY-MM-DD.md` as the dated source of truth.
- Use sections like `## NemoClaw Candidates`, `## NemoClaw Work`, and `## Writeback Needed`.
- Carry unresolved candidates forward only when they are still relevant.

## Guardrails

- Never commit secrets, tokens, local endpoints, or private notes.
- Never force-push or rewrite shared history.
- Never merge directly to `main` from a scheduled job.
- Never leave meaningful Glenn-owned repo changes only on disk; push them or record a `Writeback Needed` blocker in daily memory.
- Keep `glenn-agent/blueprint` synced with the public-safe workspace snapshot after meaningful workspace changes.
- If GitHub authentication is missing, record that blocker in today's daily memory instead of pretending the scan succeeded.
- If no worthwhile task exists, record `NO_GOOD_CANDIDATE` with the reason.
