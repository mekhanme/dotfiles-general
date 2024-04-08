[[ $commands[kubectl] ]] && alias k=kubectl && source <(kubectl completion bash) && complete -F __start_kubectl k

export STARSHIP_CONFIG=~/.config/starship.toml