# ============================================================================
# Powerlevel10k Instant Prompt (Must be at the top)
# ============================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================================
# Oh My Zsh Configuration
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git 
  git-prompt
)

source "${ZSH}/oh-my-zsh.sh"

# ============================================================================
# Runtime Configurations
# ============================================================================

# fnm (Fast Node Manager)
FNM_PATH="$HOME/Library/Application Support/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --use-on-cd)"
fi

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

# Python alias (only if not already set in .zshenv)
if [[ -z "$PYTHON_ALIAS_APPLIED" ]]; then
    alias python='python3'
    alias pip='pip3'
fi

# ============================================================================
# Shell Completions
# ============================================================================

# Bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# ============================================================================
# Powerlevel10k Configuration (Must be near the end)
# ============================================================================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
