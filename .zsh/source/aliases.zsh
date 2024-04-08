alias digs="dig +noall +answer"

alias grep="grep --color=auto"
alias ls="ls --color=auto"
alias ll="ls -lh"
alias la="l -a"

alias l="exa --long --group-directories-first --all --time-style=long-iso --color=automatic"
alias lg="exa --long --group-directories-first --all --time-style=long-iso --color=automatic --grid"
alias lt="exa --long --group-directories-first --all --time-style=long-iso --color=automatic --tree --level=2"
alias lt3="exa --long --group-directories-first --all --time-style=long-iso --color=automatic --tree --level=3"
alias lt4="exa --long --group-directories-first --all --time-style=long-iso --color=automatic --tree --level=4"
# --sort name, .name, acc, size, mod, cr, ext, old, inode

alias lsd="lsd -la"

alias ps="ps aux"

alias gpl="git pull"
alias gps="git push"
alias gu="git up"
alias gcd="git checkout ${YADM_DEV_BRANCH}"
alias gcm="git checkout ${YADM_MASTER_BRANCH}"
alias gds="git diff --staged"
alias gc-="git checkout -"
alias glg="git log --stat --show-signature"

alias t="new-session -t d"
alias tmuxre="tmux new-session -t 0 || tmux new-session -s 0"

alias r="source ~/.zshrc"
alias rsync="rsync -azP -v -e ssh"
alias fd="fd -H"

alias bat='bat --style="numbers,changes,header" --theme=TwoDark --color=always --map-syntax local:bash --map-syntax kubeconfig:yaml'
# --pager="less -FR"
alias jq="jq -C"

alias dps="docker-pretty-ps"

alias zshrc="$EDITOR ~/.zshrc"

alias dev="cd /root/dev/"
alias cloudcopy="python /usr/local/bin/cloudclip.py -c"
alias cloudpaste="python /usr/local/bin/cloudclip.py -p"

alias -g L="less"
alias -g G="grep"
alias -g X="xargs"
alias -g H="head"
alias -g T="tail"
alias -g B="bat --color=always --style=numbers"

# alias fzf="fzf-tmux"

alias fzdc='docker-compose --compatibility -f $(fzf --bind "alt-enter:execute(micro {})" -q "docker-compose yml$ " --prompt "🐳 " --header "🔰 [Enter] to run \"docker-compose up -d\" 🔰 [Alt+Enter] to edit file") up -d'

# alias docker_clean="docker rmi $(docker images -q) && docker rm -v $(docker ps -qa)"

alias -s {yml,yaml}=micro

alias d="dirs -v | head -10"
for index ({0..9}) alias "$index"="cd +${index}"; unset index

alias mkdir="mkdir -p"

alias pbc='pbcopy'
alias pbp='pbpaste'

alias po='popd'
alias pu='pushd'

alias df='df -kh'
alias du='du -kh'

alias -s {avi,mpeg,mpg,mov,m2v}=mplayer
alias -s {j2,conf,cfg,yaml.yml,json}=micro

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias 1='builtin cd -1'
alias 2='builtin cd -2'
alias 3='builtin cd -3'
alias 4='builtin cd -4'
alias 5='builtin cd -5'
alias 6='builtin cd -6'
alias 7='builtin cd -7'
alias 8='builtin cd -8'
alias 9='builtin cd -9'
alias md='mkdir -p'
