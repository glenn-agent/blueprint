# Contribution Pipeline

This file defines Glenn-Agent's current contribution loop.

## Scope

Active contribution projects (both — Glenn-Agent dogfoods OpenClaw and contributes to NemoClaw):

- `/workspace/openclaw/projects/openclaw/upstream` -> `openclaw/openclaw` (the runtime Glenn-Agent itself runs on)
- `/workspace/openclaw/projects/nemoclaw/upstream` -> `NVIDIA/NemoClaw` (NVIDIA's secure-sandbox wrapper around OpenClaw)

Glenn-Agent-owned writeback repositories:

- `/workspace/openclaw/repos/profile` -> `glenn-agent/glenn-agent`
- `/workspace/openclaw/repos/blueprint` -> `glenn-agent/blueprint`
- `/workspace/openclaw/repos/wiki` -> `glenn-agent/wiki`
- `/workspace/openclaw/repos/story` -> `glenn-agent/story`

Do not scan, start, submit, or modify unrelated contribution projects during scheduled jobs unless the user explicitly changes the focus. The Glenn-Agent-owned repos are for self-maintenance and writeback, not the primary contribution target.

## Daily Loop

1. Check the active project repo and Glenn-Agent-owned writeback repos for local changes before pulling.
2. Before starting any NemoClaw fix or investigation, fetch/pull the active NemoClaw repo from `origin/main` when the working tree is clean. If local changes exist, preserve them and record the blocker instead of overwriting them.
3. Update other clean repos from `origin/main`.
4. Inspect NemoClaw issues, tests, recent commits, CLI/runtime behavior, developer tooling, docs, and local TODOs.
5. Choose at most one small candidate for the day.
6. Default to a non-documentation-first search: small runtime/CLI bug fixes, focused regression tests, developer tooling fixes, and low-risk refactors outrank docs when they are clear and verifiable.
7. Use documentation PRs as a fallback or companion only when no safe non-doc candidate exists, the docs issue is clearly valuable, or the docs change directly supports a code/test fix.
8. If the candidate is safe and verifiable, create a topic branch.
9. For code implementation, delegate bounded edits to the local code-worker (see `TOOLS.md`) when available. Otherwise implement directly.
10. Review worker or direct edits with `git diff`, then run the relevant checks.
11. Open or prepare a PR only when the change is clear, tested, and scoped.
12. Record progress in today's daily memory file: `/workspace/openclaw/memory/YYYY-MM-DD.md`.
13. Add immediate wiki/story/profile/blueprint writeback only when clearly required.
14. Otherwise, let the scheduled writeback review job promote durable lessons to public surfaces.
15. If any workspace file changed outside `/workspace/openclaw/repos`, run `/workspace/openclaw/repos/blueprint/scripts/sync-workspace.sh` so `glenn-agent/blueprint` mirrors the public-safe workspace snapshot.
16. Commit and push any changed Glenn-Agent-owned writeback repo after diff review and secret checks.

## Date Organization

- Use `/workspace/openclaw/memory/YYYY-MM-DD.md` as the dated source of truth.
- Use sections like `## NemoClaw Candidates`, `## NemoClaw Work`, and `## Writeback Needed`.
- Carry unresolved candidates forward only when they are still relevant.

## Guardrails

- Do not let low-risk docs work become the default contribution lane. Each daily contribution scan should explicitly look for a safe non-doc candidate first and record why it chose docs if docs are selected.
- Never commit secrets, tokens, local endpoints, or private notes.
- Never force-push or rewrite shared history.
- Never merge directly to `main` from a scheduled job.
- Never leave meaningful Glenn-Agent-owned repo changes only on disk; push them or record a `Writeback Needed` blocker in daily memory.
- Keep `glenn-agent/blueprint` synced with the public-safe workspace snapshot after meaningful workspace changes.
- If GitHub authentication is missing, record that blocker in today's daily memory instead of pretending the scan succeeded.
- If no worthwhile task exists, record `NO_GOOD_CANDIDATE` with the reason.
