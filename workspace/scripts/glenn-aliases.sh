# Glenn-Agent shell helpers — source this from ~/.bashrc and ~/.zshrc.
# Edit aliases here once; both shells pick up the change.
# Works on bash + zsh. Not valid in csh syntax.

# Ensure tools on PATH
export PATH="$HOME/.local/bin:$PATH"
[ -s "$HOME/.nvm/nvm.sh" ] && . "$HOME/.nvm/nvm.sh" >/dev/null 2>&1

# --- daemon control ---
alias glenn-status='openclaw status'
alias glenn-start='systemctl --user start openclaw-gateway'
alias glenn-stop='systemctl --user stop openclaw-gateway'
alias glenn-restart='systemctl --user restart openclaw-gateway'
alias glenn-log='journalctl --user -u openclaw-gateway -f'

# --- talk to Glenn ---
alias glenn-chat='openclaw chat'
alias glenn-ask='openclaw agent --agent main -m'   # usage: glenn-ask "what did you do today?"

# --- inspect ---
alias glenn-mem='cat /workspace/openclaw/memory/$(date +%Y-%m-%d).md 2>/dev/null || echo "(no entry today)"'
alias glenn-cron='openclaw cron list --all'
alias glenn-prs='gh search prs --author glenn-agent --limit 20'
alias glenn-runs='openclaw cron runs --id e34499d7-0821-4c41-8591-c0da965e824d --limit 5'

# --- workspace shortcut ---
alias glenn-cd='cd /workspace/openclaw'
