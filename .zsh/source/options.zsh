setopt extendedglob
setopt menucomplete


# setopt auto_list              # automatically list choices on ambiguous completion
# setopt auto_menu              # automatically use menu completion
# setopt always_to_end          # move cursor to end if word had one match

# https://github.com/thoughtbot/dotfiles/blob/master/zsh/configs/options.zsh
# awesome cd movements from zshkit
# setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
# DIRSTACKSIZE=5

# Enable extended globbing
# setopt extendedglob

# # Smart URLs
# autoload -Uz url-quote-magic
# zle -N self-insert url-quote-magic

# # General
# setopt BRACE_CCL          # Allow brace character class list expansion.
# setopt RC_QUOTES          # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
# unsetopt MAIL_WARNING     # Don't print a warning message if a mail file has been accessed.

# If you now paste a url it will be magically quoted!
# autoload -Uz url-quote-magic
# zle -N self-insert url-quote-magic

# # Setup new style completion system. To see examples of the old
# # style -- compctl based -- programmable completion, check
# # Misc/compctl-examples in the zsh distribution.
# # autoload -Uz compinit
# # compinit

# # Keysbinds
# # Use ^v to find out the keynames
# # bindkey -e                 # emacs key bindings
# # bindkey ' '  magic-space   # also do history expansion on space
# # bindkey '^I' complete-word # complete on tab, leave expansion to _expand





# Changing Directories 📁

# быстрый переход в директорию
setopt AUTO_CD
# автоматический переход в директорию и обратно с помощью pushd/popd
# или ~# (где # - номер директории в dirs -v)
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_TO_HOME

# completion
setopt alwaystoend

# expansion and globbing

# History options 📜
# http://zsh.sourceforge.net/Doc/Release/Options.html#History

# новая команда не добавится в $HISTFILE, если такая запись уже есть
unsetopt HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
# использовать системный вызов fcntl для лока $HISTFILE
setopt HIST_FCNTL_LOCK
# удалять лишние пробелы при записи в $HISTFILE
setopt HIST_REDUCE_BLANKS
# не выполнять команду сразу при выполнении history expansion
setopt HIST_VERIFY
# добавлять таймпстамп и время выполнения команды в $HISTFILE
setopt EXTENDED_HISTORY
# инкрементально (сразу после ввода) добавлять команды в $HISTFILE
setopt INC_APPEND_HISTORY
# шарить/не шарить историю между сессиями zsh (используется для local-history)
setopt SHARE_HISTORY

# Initialisation

# отключить/включить автоматический экспорт всех параметров
unsetopt ALL_EXPORT

# Jobs
# не работает
# список процессов в long формате
setopt LONG_LIST_JOBS
# авто восстановление запущенного job перед созданием нового процесса
setopt AUTO_RESUME
setopt NOTIFY             # Report status of background jobs immediately.
# отключить/включить запуск background процессов с пониженным приоритетом
unsetopt BG_NICE          # Don't run all background jobs at a lower priority.
# убивать/не убивать процессы при выходе из шелла
unsetopt HUP
unsetopt CHECK_JOBS       # Don't report on jobs when shell exit.

# Input/Output 💽

# пытаться/не пытаться исправлять опечатки
unsetopt CORRECT_ALL

# отключить/включить ^S/^Q
unsetopt FLOW_CONTROL

# поддержка комментариев в командной строке
setopt INTERACTIVE_COMMENTS

# печатать exit status, если он не равен 0
setopt PRINT_EXIT_VALUE

# Prompting 🉑

# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
# поддержка $(cmd) в $PS1 etc
setopt PROMPT_SUBST

# setopt transientrprompt ?

# scripts and functions

# ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️  ☸️

# TODO:разобраться с локальной и глобальной историей
# https://superuser.com/questions/446594/separate-up-arrow-lookback-for-local-and-global-zsh-history/1302969

# поддержка ~… и file completion после = в аргументах
# echo foo=~/bar:~/rod -> foo=/root/bar:/root/rod
setopt MAGIC_EQUAL_SUBST

# традиционный стиль перенаправлений fd
unsetopt MULTIOS

# не обрабатывать escape sequence в echo без -e
setopt BSD_ECHO


