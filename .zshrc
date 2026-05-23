# ============================================================================
# Runtime Configurations
# ============================================================================

# fnm (Fast Node Manager)
eval "$(fnm env --use-on-cd)"

# npm global packages
if command -v npm &> /dev/null; then
  export PATH="$PATH:$(npm config get prefix)/bin"
fi

# Python user packages (dynamic)
if command -v python3 &> /dev/null; then
  PYTHON_VERSION=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
  export PATH="$HOME/Library/Python/${PYTHON_VERSION}/bin:$PATH"
fi

# ============================================================================
# Aliases
# ============================================================================

# Python alias
alias python='python3'
alias pip='pip3'

alias lzd='lazydocker'
alias ls="ls --color=always"
alias l="ls -lah"

# ============================================================================
# Shell Completions
# ============================================================================

# Bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# ============================================================================
# Addons
# ============================================================================

# fzf
source <(fzf --zsh)

# docker
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/zuratsintsadze/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# starship
eval "$(starship init zsh)"
