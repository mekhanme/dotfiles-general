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

#TODO: не работает
# Начни вводить команду + [Up-Arrow] - fuzzy find history
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -Uz up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# Начни вводить команду + [Down-Arrow] - fuzzy find history backward
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

# Перемещение по completion menu назад
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

# Редактировать команду в $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

# file rename magick
bindkey "^xm" copy-prev-shell-word

# opinionated bindings
# bindkey '^r'              history-incremental-search-backward

bindkey ${terminfo[kcbt]} reverse-menu-complete

# make sure terminfo keys make actual sense
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

# ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️

bindkey -s '^xy' '^Uyadm pull && source ${ZDOTDIR:-$HOME}/.zshrc^M'
bindkey -s '^x^y' '^Uyadm nc && yadm push^M'

# TODO: доделать
_yadm-status() {
  zle kill-whole-line
  zle -U "yadm status -s^M"
  zle accept-line
}
zle -N _yadm-status
bindkey -s '^x^s' _yadm-status

# [Ctrl-x w] пропишет 'echo $'
bindkey -s '^xw' '^Uecho $'
# [Ctrl-x W] пропишет 'echo '
bindkey -s '^xW' '^Uecho '

# Ctrl-g пропишет ' | grep '
# bindkey -s '^g' ' | grep '

bindkey -s '^[d' 'fzdc^M'

# запустить $EDITOR с содержимым буфера обмена
bindkey -s '^xj' 'micro <<<$(xclip -o)^M'

# импортировать глобальную историю в локальную сессию zsh
bindkey -s '^xh' 'fc -RI^M'

# https://github.com/tomsquest/dotfiles/blob/master/zsh/bindkey.zsh
# Вставить результат выполнения последней команды
zmodload -i zsh/parameter
insert-last-command-output() {
  LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N insert-last-command-output
bindkey '^x^x' insert-last-command-output

# Execute the current suggestion (using zsh-autosuggestions)
# Alt+Enter = '^[^M' on recent VTE and '^[^J' for older (Lxterminal)
# bindkey '^[^M' autosuggest-execute
# bindkey '^[^J' autosuggest-execute

# https://superuser.com/questions/446594/separate-up-arrow-lookback-for-local-and-global-zsh-history
# перемещение по локальной истории с помощью [ Up / Down ], а по глобальной с [ Ctrl-Up / Ctrl-Down ]
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

# https://unix.stackexchange.com/questions/537494/zsh-reuse-all-arguments-from-previous-command
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

# https://github.com/leophys/zsh-plugin-fzf-finder/blob/master/fzf-finder.plugin.zsh

# [ Ctrl - P ]
# bindkey -r "^p"
# bindkey '^p' fuzzy-search-and-edit


# [ Alt - P ]
bindkey -r "^[p"
# bindkey "^[p"

# [ Ctrl - O ] запустить lf с изменением CWD
# https://github.com/gokcehan/lf/blob/master/etc/lfcd.sh
bindkey -r '^o'
bindkey -s '^o' 'lfcd\n'

# [ Alt - L ]
# Отправить вывод команды в bat
# TODO: Сделать дополнение http --pretty=all, и вставку команды до изменения на новую строку
bindkey -r "^[l"
bindkey -s '^[l' ' | bat --color=always --style=numbers^M'