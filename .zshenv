# ============================================================================
# .zshenv - Environment variables (loaded for all shells)
# ============================================================================

# Path configurations
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# NVM configuration
export NVM_DIR="$HOME/.nvm"

# Python alias environment
export PYTHON_ALIAS_APPLIED=true

# Pear Runtime
export PATH="$HOME/Library/Application Support/pear/bin:$PATH"

# Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Local bin
export PATH="$HOME/.local/bin:$PATH"

# Ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$(gem environment gemdir)/bin:$PATH"
#
# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
