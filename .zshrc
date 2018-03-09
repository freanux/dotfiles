#USE_PROMPT_SUFFIX=1
. ${HOME}./.zsh/base.zshrc
zstyle ':completion:*' users-hosts 

. ${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# MUST BE AT THE END OF THIS FILE
. ${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_STYLES[builtin]='fg=226'
ZSH_HIGHLIGHT_STYLES[alias]=$ZSH_HIGHLIGHT_STYLES[builtin]
ZSH_HIGHLIGHT_STYLES[command]='fg=46'
