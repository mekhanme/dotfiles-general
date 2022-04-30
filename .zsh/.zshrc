autoload -U +X compinit && compinit
# autoload -Uz compinit

# declare -A ZINIT
# # export ZINIT[HOME_DIR]="${HOME}/.local/share/zinit/zinit.git/zinit.zsh"
# # export ZINIT[HOME_DIR]="${ZDOTDIR:-$HOME}/.zinit"
# export ZINIT[COMPINIT_OPTS]="-C"
# export ZINIT[MUTE_WARNINGS]=0
# # mkdir ${HOME}/bin
# export ZPFX="${HOME}/bin"
# # module_path+=( "${ZPLGM[HOME_DIR]}/bin/zmodules/Src" )
# # zmodload zdharma/zplugin
# # zpmod source-study

# NOTE: https://z-shell.pages.dev/docs/getting_started/installation
source "${HOME}/.zsh/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

for f (${ZDOTDIR:-$HOME}/source/*.zsh(N.)) source $f

autoload -Uz ${ZDOTDIR:-$HOME}/functions/*(:t)

source "${ZDOTDIR:-$HOME}/.zshrc.local"

emulate sh -c '. ${HOME}/.profile'

# autoload -Uz compinit && compinit -C