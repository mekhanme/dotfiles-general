declare -A ZINIT
export ZINIT[HOME_DIR]="${HOME}/.local/share/zinit"
export ZINIT[BIN_DIR]="${HOME}/.local/share/zinit/zinit.git"
export ZINIT[COMPINIT_OPTS]="-C"
export ZINIT[MUTE_WARNINGS]=0
export ZPFX="${HOME}/builds"

source ${ZINIT[BIN_DIR]}/zinit.zsh

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

source ${ZDOTDIR}/.zshrc.local