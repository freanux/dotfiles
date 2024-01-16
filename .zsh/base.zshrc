# The following lines were added by compinstall
#zstyle :compinstall filename '/home/flynn/.zshrc'

autoload -Uz compinit
compinit

################################################################################################
# COMPLETION
################################################################################################
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE

# Enable approximate completions (w/o correction)
#zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' completer _complete _ignored

zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3)) numeric)'

# Automatically update PATH entries
zstyle ':completion:*' rehash true

# Use menu completion
zstyle ':completion:*' menu select

# Verbose completion results
zstyle ':completion:*' verbose true

# Smart matching of dashed values, e.g. f-b matching foo-bar
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*'

# Group results by category
zstyle ':completion:*' group-name ''

# Don't insert a literal tab when trying to complete in an empty buffer
# zstyle ':completion:*' insert-tab false

# Keep directories and files separated
zstyle ':completion:*' list-dirs-first true

# Don't try parent path completion if the directories exist
zstyle ':completion:*' accept-exact-dirs true

# Always use menu selection for `cd -`
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

# Pretty messages during pagination
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Nicer format for completion messages
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:corrections' format '%U%F{green}%d (errors: %e)%f%u'
zstyle ':completion:*:warnings' format '%F{202}%BSorry, no matches for: %F{214}%d%b'

# Show message while waiting for completion
zstyle ':completion:*' show-completer true

# Prettier completion for processes
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,args -w -w"

# Use ls-colors for path completions
function _set-list-colors() {
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
	unfunction _set-list-colors
}
sched 0 _set-list-colors  # deferred since LC_COLORS might not be available yet

# Don't complete hosts from /etc/hosts
zstyle -e ':completion:*' hosts 'reply=()'

# Don't complete uninteresting stuff unless we really want to.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|TRAP*)'
zstyle ':completion:*:*:*:users' ignored-patterns \
		adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
		clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
		gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
		ldap lp mail mailman mailnull man messagebus mldonkey mysql nagios \
		named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
		operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
		rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
		usbmux uucp vcsa wwwrun xfs cron mongodb nullmail portage redis \
		shoutcast tcpdump '_*'
zstyle ':completion:*' single-ignored show


################################################################################################
# HISTORY
################################################################################################
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob notify histignoredups

################################################################################################
# PROMPT
################################################################################################
if [ -z "$USE_PROMPT_SUFFIX" ]; then
	local PROMPT_SUFFIX=; 
else 
	local PROMPT_SUFFIX='%F{214} %m %F{242}';
fi
case $(tty) in 
/dev/tty[0-9]*)
	if [ $UID -eq 0 ]; then
        PROMPT='%n@%m:%~# '
	else
        PROMPT='%n@%m:%~$ '
	fi
	;;
*)
	export TERM=screen-256color
	if [ $UID -eq 0 ]; then
        PROMPT='%f%K{9} %n %F{9}%K{238}'${PROMPT_SUFFIX}'%F{250} %~ %F{238}%k %f'
	else
        PROMPT='%f%K{23} %n %F{23}%K{238}'${PROMPT_SUFFIX}'%F{250} %~ %F{238}%k %f'
	fi
	;;
esac

################################################################################################
# VARIOUS
################################################################################################
setopt interactivecomments
unsetopt beep nomatch

################################################################################################
# ALIASES
################################################################################################
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias s='ssh -p99999 user@host'
alias jc="journalctl"
alias sc="systemctl"
alias ta="tmux att"

################################################################################################
# BINDS
################################################################################################
my-backward-delete-word() {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-delete-word
}
zle -N my-backward-delete-word

bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[5C" forward-word
bindkey "^[^[[C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[5D" backward-word
bindkey "^[^[[D" backward-word
bindkey "^[[1~" beginning-of-line
bindkey "^[[H" beginning-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[F" end-of-line
bindkey "^[OF" end-of-line
bindkey "^[[3~" delete-char
bindkey '^W' my-backward-delete-word
bindkey '^H' my-backward-delete-word
bindkey -s '^[[1;3D' '^Ucd ..^M'
bindkey -s '^[[1;3A' '^Ucd^M'
bindkey -s '^[[1;3B' '^Ucd -^M'

################################################################################################
# MAN IN COLOR
################################################################################################
export MANPAGER="less"
export LESS_TERMCAP_mb=$'\E[1;31m'      # begin blinking
export LESS_TERMCAP_md=$'\E[1;31m'      # begin bold
export LESS_TERMCAP_me=$'\E[0m'         # end mode
export LESS_TERMCAP_so=$'\E[1;37;44m'   # begin standout-mode - info box
export LESS_TERMCAP_se=$'\E[0m'         # end standout-mode
export LESS_TERMCAP_us=$'\E[1;33m'      # begin underline
export LESS_TERMCAP_ue=$'\E[0m'         # end underline

################################################################################################
# fzf SETTINGS (COLOR SCHEME aliases)
################################################################################################
export FZF_DEFAULT_OPTS='--color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934'
