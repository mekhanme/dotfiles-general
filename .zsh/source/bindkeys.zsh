# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

bindkey -e

if [[ "${terminfo[kpp]}" != "" ]]; then
  bindkey "${terminfo[kpp]}" up-line-or-history
fi
if [[ "${terminfo[knp]}" != "" ]]; then
  bindkey "${terminfo[knp]}" down-line-or-history
fi

if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -Uz up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -Uz down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow]
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow]

### ctrl+delete
bindkey "\e[3;5~" kill-word
### ctrl+backspace
bindkey '^H' backward-kill-word
### ctrl+shift+delete
bindkey "\e[3;6~" kill-line

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab]
fi

bindkey '^?' backward-delete-char                     # [Backspace]
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char            # [Delete]
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

bindkey "^xm" copy-prev-shell-word

# bindkey '^r'              history-incremental-search-backward

bindkey ${terminfo[kcbt]} reverse-menu-complete

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init () {
      echoti smkx
  }
  function zle-line-finish () {
      echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# [Ctrl-x w]
bindkey -s '^xw' '^Uecho $'
# [Ctrl-x W]
bindkey -s '^xW' '^Uecho '
bindkey -s '^[d' 'fzdc^M'
bindkey -s '^xj' 'micro <<<$(xclip -o)^M'
bindkey -s '^xh' 'fc -RI^M'

zmodload -i zsh/parameter
insert-last-command-output() {
  LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N insert-last-command-output
bindkey '^x^x' insert-last-command-output

# bindkey '^[[1;5A' up-line-or-history              # Ctrl-Up
bindkey '^[[1;5A' history-substring-search-up       # Ctrl-Up
# bindkey '^[[1;5B' down-line-or-history            # Ctrl-Down
bindkey '^[[1;5B' history-substring-search-down     # Ctrl-Down
bindkey '^[[A' up-line-or-local-history             # Up
bindkey '^[[B' down-line-or-local-history           # Down
zle -N history-substring-search-up
zle -N history-substring-search-down

up-line-or-local-history() {
    zle set-local-history 1
    zle up-line-or-history
    zle set-local-history 0
}
zle -N up-line-or-local-history
down-line-or-local-history() {
    zle set-local-history 1
    zle down-line-or-history
    zle set-local-history 0
}
zle -N down-line-or-local-history

insert-last-words() {
  emulate -L zsh
  set -o extendedglob

  if [[ $WIDGET = $LASTWIDGET ]]; then
    # subsequent invocations go further back in history like
    # insert-last-word

    zle undo # previous invocation
    ((INSERT_LAST_WORDS_INDEX += ${1--1}))
  else
    INSERT_LAST_WORDS_INDEX=0
  fi

  local lastwords
  local cmd=${history:$INSERT_LAST_WORDS_INDEX:1}
  lastwords=(${(z)cmd})
  (($#lastwords > 1)) || return

  cmd=${cmd##[[:space:]]#$lastwords[1][[:space:]]#}
  LBUFFER+=$cmd
}
zle -N insert-last-words
bindkey '\e,' insert-last-words

# [ Alt - P ]
bindkey -r "^[p"
# bindkey "^[p"
# [ Ctrl - O ]
bindkey -r '^o'
bindkey -s '^o' 'lfcd\n'
# [ Alt - L ]
bindkey -r "^[l"
bindkey -s '^[l' ' | bat --color=always --style=numbers^M'