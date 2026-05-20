# Writeback Policy

Writeback is handled primarily by scheduled review, not by forcing every agent reply to include a fixed review block.

The review asks whether recent work created durable value that should be preserved in Glenn's public or private knowledge surfaces. The answer may be "no", but the scheduled review must happen.

## Scheduled Review

A periodic writeback review job checks recent memory and workspace/repo activity for:

1. Should today's memory be updated?
2. Should `repos/wiki` be updated?
3. Should `repos/story` be updated?
4. Should `repos/blueprint` be synced?
5. Should `repos/profile` be updated?

Claude Code's project memory handles routine continuity. For scheduled jobs, contribution work, operating-rule changes, deployments, PRs, and other meaningful state changes, add concise daily memory notes in `/workspace/openclaw/memory/YYYY-MM-DD.md`.

## Update Wiki When

Update `/workspace/openclaw/repos/wiki` when the task produced reusable technical knowledge, such as:

- a repeatable setup or deployment process
- a debugging method
- a project-specific field note
- a maintainer or review preference
- a mistake pattern worth preventing
- a durable concept that future Glenn should know

Do not update wiki for routine syncs, one-off status checks, or duplicate notes.

## Update Story When

Update `/workspace/openclaw/repos/story` when the task is part of Glenn's public journey, such as:

- a real open-source contribution
- a public project milestone
- a website or profile launch
- a meaningful change in operating model
- a useful retrospective after failure or review

Do not update story for private-only details, routine maintenance, or trivial local changes.

## Update Blueprint When

Update `/workspace/openclaw/repos/blueprint` whenever public-safe workspace files change. Run:

```bash
/workspace/openclaw/repos/blueprint/scripts/sync-workspace.sh
```

Then review the diff, check for secrets, commit, and push.

## Commit Rule

Any Glenn-owned repo changed by writeback must be reviewed, secret-checked, committed, and pushed promptly. If pushing fails, add a `Writeback Needed` entry to today's memory.

Commit messages must follow the typed Commit Message Policy in `AGENTS.md` unless an upstream repository documents a stricter convention.

## Secret Hygiene

Universal rules that apply to every commit, every public surface, every channel:

- Never write API keys, GitHub tokens, OAuth secrets, private endpoints, credentials, or session cookies into any file Glenn might publish.
- Never paste content from private conversations, internal email, internal wikis, or any source the operator has only because of authenticated access — unless the operator has explicitly approved that specific content for publication.
- Keep secret material in `~/.openclaw/.env` (or equivalent OpenClaw SecretRef storage). Local-only, chmod 600.
- If a credential ever appears in chat, logs, shell history, or anywhere it could be cached, rotate it.

## Enforcement Model

Enforcement relies on:

1. **Agent self-policing** during work — Glenn reads this file when working on any writeback or public content.
2. **Scheduled writeback review job** — runs periodically, reviews recent memory and decides what should be promoted to public surfaces.
3. **Secret scan before every commit** — `git diff --cached` reviewed for the patterns above before pressing commit.
