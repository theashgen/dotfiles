eval "$(starship init zsh)"

# freebuff herdr plugin wrapper — must stay AHEAD of ~/.bun/bin so the wrapper
# (which spawns the herdr lifecycle watcher) shadows the real binary; no-op outside Herdr

# Added by Antigravity IDE
export PATH="$HOME/.antigravity-ide/antigravity-ide/bin:$PATH"

# Go path
export PATH="$PATH:$(go env GOPATH)/bin"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"


export PATH="/Users/theashgen/.bun/bin:$PATH"

# freebuff herdr plugin wrapper must precede ~/.bun/bin (see comment above)
export PATH="$HOME/.local/bin:$PATH"

# zoxide
eval "$(zoxide init zsh)"

alias cd=z
alias nosleep="sudo pmset -a disablesleep 1"
alias yessleep="sudo pmset -a disablesleep 0"


# Added by Antigravity CLI installer
export PATH="/Users/theashgen/.local/bin:$PATH"
