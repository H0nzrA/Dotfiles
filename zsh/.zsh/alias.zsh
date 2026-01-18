# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# eza - SAFE: 100% compatible with ls, just prettier
if command -v eza &> /dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza --icons --group-directories-first -l'
    alias la='eza --icons --group-directories-first -la'
    alias lt='eza --icons --group-directories-first --tree'
    alias lsa='eza --icons --group-directories-first -lah'
fi

# zoxide - SAFE: keeps 'cd' working, adds 'z' for smart jumping
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh 2>/dev/null)"
fi

# Navigation aliases (safe, don't break anything)
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Human-readable output (safe enhancements)
alias df='df -h'
alias du='du -h'
alias free='free -h'

# Git aliases (very useful, don't conflict)
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
