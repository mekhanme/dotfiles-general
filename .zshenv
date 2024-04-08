export ZDOTDIR="${HOME}/.zsh"
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

skip_global_compinit=1

typeset -aU path

if [[ -z $ENV ]] && [[ -n $PATH ]]; then
  case $- in
    *l*) ;;
    *) [[ -f ${HOME}/.profile ]] && source ${HOME}/.profile ;;
  esac
fi

[[ -f ${HOME}/.zshenv.local ]] && source ${HOME}/.zshenv.local