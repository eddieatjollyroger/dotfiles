# Prompt
PS1='➜ '

# Envars
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export HISTCONTROL=ignoredups
export HISTSIZE=1000000
export PATH=~/wmutils:"${PATH}":~/.gem/ruby/2.5.0/bin:~/go/bin:~/.local/bin:~/bin:~/.npm-packages/bin:~/.fzf/bin
export EDITOR="nvim"
export FZF_DEFAULT_COMMAND='rg --files --hidden'

# Better TAB completion.
bind 'TAB: menu-complete'
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'set completion-map-case on'
bind 'set page-completions off'
bind 'set menu-complete-display-prefix on'
bind 'set completion-query-items 0'

# History completion.
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# FZF file finder
bind '"": "fze\n"'

# Functions.
. ~/bin/lcd
(cat ~/.cache/wal/sequences &)

# Aliases.
alias anakin="sudo pacman -Rns \$(pacman -Qtdq)"
alias neofetch="clear; neofetch"
alias refugees="pacman -Qm"
alias fixwifi="sudo modprobe -r iwlmvm; sudo modprobe iwlmvm"
alias yeah="yes"
alias gj="git add .; git commit -m 'docs: update'; git push"
alias cd="lcd"
alias ls="ls --group-directories-first --color=always -A"

[[ -z "$DISPLAY" && "$XDG_VTNR" -eq 1 ]] && \
    exec startx -- -keeptty > ~/.xorg.log 2>&1

[[ -z "$TMUX"  ]] && exec tmux
