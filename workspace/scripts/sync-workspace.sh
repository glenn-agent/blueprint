#!/usr/bin/env bash
# sync-workspace.sh — Mirror /workspace/openclaw to the blueprint repo as a public-safe snapshot.
#
# Lives at /workspace/openclaw/scripts/sync-workspace.sh as the canonical source.
# On bootstrap-public-repos.sh run, a copy is placed inside the blueprint repo at
# /workspace/openclaw/repos/blueprint/scripts/sync-workspace.sh for cron jobs.
#
# Excludes things that must never reach the public blueprint repo:
#   - local clones (/repos, /projects)
#   - runtime caches and DBs
#   - environment / credential files
#   - dot-prefixed runtime dirs created by OpenClaw

set -euo pipefail

WORKSPACE_ROOT="${WORKSPACE_ROOT:-/workspace/openclaw}"
BLUEPRINT_REPO="${BLUEPRINT_REPO:-${WORKSPACE_ROOT}/repos/blueprint}"
DESTINATION="${BLUEPRINT_REPO}/workspace"

if ! command -v rsync >/dev/null 2>&1; then
  echo "rsync is required for workspace sync" >&2
  exit 1
fi

if [ ! -d "${WORKSPACE_ROOT}" ]; then
  echo "workspace root does not exist: ${WORKSPACE_ROOT}" >&2
  exit 1
fi

if [ ! -d "${BLUEPRINT_REPO}" ]; then
  echo "blueprint repo does not exist: ${BLUEPRINT_REPO}" >&2
  echo "Run bootstrap-public-repos.sh first." >&2
  exit 1
fi

mkdir -p "${DESTINATION}"

rsync -a --delete \
  --exclude '/repos/' \
  --exclude '/projects/' \
  --exclude '/worktrees/' \
  --exclude '/scripts/install-openclaw.sh' \
  --exclude '/scripts/setup-model.sh' \
  --exclude '/scripts/bootstrap-public-repos.sh' \
  --exclude '/memory/.dreams/' \
  --exclude '/tmp/' \
  --exclude '/.git/' \
  --exclude '/.openclaw/' \
  --exclude '/.env' \
  --exclude '/*.sqlite' \
  --exclude '/*.sqlite-*' \
  --exclude '/*.log' \
  "${WORKSPACE_ROOT}/" "${DESTINATION}/"

echo "Synced ${WORKSPACE_ROOT} -> ${DESTINATION}"
