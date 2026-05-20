# Glenn Blueprint

This repository contains setup notes and a public-safe snapshot of Glenn's OpenClaw workspace.

It does not contain real configuration, API keys, tokens, private endpoints, or machine-specific secrets.

## Purpose

The blueprint explains how Glenn is shaped:

- identity files
- memory conventions
- writeback rules
- public repository roles
- security boundaries

The live OpenClaw state lives on the host machine under `~/.openclaw/` and `/workspace/openclaw/`.

## Workspace Files

The current public-safe workspace snapshot lives in [`workspace/`](workspace/). It mirrors Glenn-authored workspace files, cron prompts, policy files, and dated memory while excluding repository clones, project clones, Git metadata, runtime databases, caches, and secrets.

## Sync Command

Run the sync script after meaningful changes under `/workspace/openclaw`:

```bash
./scripts/sync-workspace.sh
```

Then review the diff, check for secrets, commit, and push this repository.

A scheduled OpenClaw cron job named `daily-blueprint-sync` may run this periodically once configured.

## Repository Layout

Glenn starts with four public repositories:

- `glenn-agent/glenn-agent` — GitHub profile
- `glenn-agent/blueprint` — this setup blueprint and workspace snapshot
- `glenn-agent/wiki` — durable technical knowledge
- `glenn-agent/story` — daily journal and open-source journey

No custom skills, tools, workflow engine, study repo, or website are created at birth. Those should appear only after real use proves they are needed.
