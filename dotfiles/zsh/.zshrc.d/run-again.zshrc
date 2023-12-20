# https://stackoverflow.com/a/28938270

# define function that retrieves and runs last command
function run-again {
    # get previous history item
    zle up-history
    # confirm command
    zle accept-line
}

# define run-again widget from function of the same name
zle -N run-again

# In iterm config, there's a corresponding escape sequence mapping `[[SEi`. It's _deliberate_ to append an _i_ to simulate returning to insert mode. Since the key sequence begins with escape, returning to insert mode is needed for repeat invocations.
bindkey -M viins '[[SE' run-again 
bindkey -M vicmd '[[SE' run-again 

# Provides another override that doesn't require iTerm specific config so that it's compatible with other environments like intellij.
bindkey -M viins '^O' run-again 
bindkey -M vicmd '^O' run-again 
