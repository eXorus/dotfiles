# Load Composer tools
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Load UtilityScripts AWS
export PATH="$HOME/Code/UtilityScripts/AWS/bin:$PATH"

# Load WAT
export PATH="$HOME/Code/wat/bin:$PATH"

# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Use project-specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"
