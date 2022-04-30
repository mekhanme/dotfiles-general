#TODO: сделать на какую-то клавишу просмотр статуса
_fzf_docker_compose_up() {
  local DOCKER_COMPOSE_DIR="~/dev/Docker"
  local FZF_OPTIONS=(
    --preview-window=right:60%:wrap
    --delimiter "/"
    --header "🔰 [Enter] to run \"docker-compose up -d\" 🔰 [Alt+Enter] to edit file"
    --bind "alt-enter:execute(micro {})"
    --preview '[[ {-1} =~ ^docker-compose.?*.ya?ml$ ]] &&
      echo "🔰 {}" ;
      docker-compose --compatibility -f {} ps 2>&1 ;
      echo "🔰" ;
      bat --style=numbers --color=always {} ;
      echo "🔰"'
  )
  local docker_compose_file=$(fd docker-compose $(eval echo ${DOCKER_COMPOSE_DIR:-`pwd`}) -d 2 -t f | fzf ${FZF_OPTIONS[@]})
  docker-compose --compatibility -f $docker_compose_file up -d
}
#    --expect=f1,f2,~,@
#      echo "🔰  🔰  🔰  🔰  🔰  🔰  🔰  🔰" ;

# local container=$(docker ps -a --format '{{.Names}} => {{.Image}}' | fzf-tmux --reverse --multi | awk -F '\\=>' '{print $1}')

# TODO: не работает в fzf
# docker-pretty-ps -a $(yq ".services | keys | .[]" docker-compose.yml | xargs | sed "s/ /,/g" | tr -d "\n")

# if [ -z `docker-compose ps -q <service_name>` ] || [ -z `docker ps -q --no-trunc | grep $(docker-compose ps -q <service_name>)` ]; then
#   echo "No, it's not running."
# else
#   echo "Yes, it's running."
# fi


alias fzdc='_fzf_docker_compose_up
  --prompt "🐳 "
  --header "🔰 [Enter] to run \"docker-compose up -d\" 🔰 [Alt+Enter] to edit file"
  --bind "alt-enter:execute(micro {})"
  --delimeter "/"
  --preview "[[ {-1} =~ ^docker-compose.?*.ya?ml$ ]] && docker-compose --compatibility -f {} ps"
'

# TODO: сделать инспекцию объектов докера через fzf
# fd _logs /var/lib/docker/volumes -d 1 -t d | fzf


# # Examples
#
# fzf_find_edit() {
#     local file=$(
#       fzf --no-multi --preview 'bat --color=always --line-range :500 {}'
#       )
#     if [[ -n $file ]]; then
#         $EDITOR $file
#     fi
# }
# alias ffe='fzf_find_edit'

fzf_grep_edit(){
    if [[ $# == 0 ]]; then
        echo 'Error: search term was not provided.'
        return
    fi
    local match=$(
      rg --color=never --line-number "$1" |
        fzf --no-multi --delimiter : \
            --preview "bat --color=always {2}: {1}"
      )
    local file=$(echo "$match" | cut -d':' -f1)
    if [[ -n $file ]]; then
        $EDITOR $file +$(echo "$match" | cut -d':' -f2)
    fi
}
# TODO: сделать показ строк до и после
# $(( 10 - 3 ))
# --preview "bat --color=always --line-range $(echo {2} | xargs -n 1 expr -12 +): {1}"
# --preview "bat --color=always --line-range {2}: {1}"
# --preview "lines=$(expr ${2} - 5) ; bat --color=always --line-range ${lines}: {1}"

alias fge='fzf_grep_edit'

# https://www.reddit.com/r/commandline/comments/fu6zzp/search_file_content_with_fzf/
# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}
# alternative using ripgrep-all (rga) combined with fzf-tmux preview
# implementation below makes use of "open" on macOS, which can be replaced by other commands if needed.
# allows to search in PDFs, E-Books, Office documents, zip, tar.gz, etc. (see https://github.com/phiresky/ripgrep-all)
# find-in-file - usage: fif <searchTerm> or fif "string with spaces" or fif "regex"
fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    local file
    file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$@" | fzf-tmux +m --preview="rga --ignore-case --pretty --context 10 '"$@"' {}")" && open "$file"
}

# Пример c git
# https://junegunn.kr/2016/07/fzf-git/

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}

gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

fzf-gt-widget() LBUFFER+=$(gh | join-lines)
zle -N fzf-gt-widget
bindkey '^g^h' fzf-gt-widget