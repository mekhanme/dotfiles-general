# MIT (c) Wenxuan Zhang
y_forgit::warn() { printf "%b[Warn]%b %s\n" '\e[0;33m' '\e[0m' "$@" >&2; }
y_forgit::info() { printf "%b[Info]%b %s\n" '\e[0;32m' '\e[0m' "$@" >&2; }
y_forgit::inside_work_tree() { yadm rev-parse --is-inside-work-tree >/dev/null; }

# https://github.com/wfxr/emoji-cli
hash emojify &>/dev/null && forgit_emojify='|emojify'

forgit_pager=`git config core.pager || echo 'cat'`

# git commit viewer
y_forgit::log() {
    y_forgit::inside_work_tree || return 1
    local cmd opts
    cmd="echo {} |grep -Eo '[a-f0-9]+' |head -1 |xargs -I% yadm show --color=always % $* | $forgit_pager"
    opts="
        $FORGIT_FZF_DEFAULT_OPTS
        +s +m --tiebreak=index --preview=\"$cmd\"
        --bind=\"enter:execute($cmd | LESS='-R' less)\"
        --bind=\"ctrl-y:execute-silent(echo {} |grep -Eo '[a-f0-9]+' | head -1 | tr -d '\n' |${FORGIT_COPY_CMD:-pbcopy})\"
        $FORGIT_LOG_FZF_OPTS
    "
    eval "yadm log --graph --color=always --format='%C(auto)%h%d %s %C(black)%C(bold)%cr' $* $forgit_emojify" |
        FZF_DEFAULT_OPTS="$opts" fzf
}

# git diff viewer
y_forgit::diff() {
    y_forgit::inside_work_tree || return 1
    local cmd files opts commit repo
    [[ $# -ne 0 ]] && {
        if yadm rev-parse "$1" -- &>/dev/null ; then
            commit="$1" && files=("${@:2}")
        else
            files=("$@")
        fi
    }

    repo="$(yadm rev-parse --show-toplevel)"
    target="\$(echo {} | sed 's/.*]  //')"
    cmd="yadm diff --color=always $commit -- $repo/$target | $forgit_pager"
    opts="
        $FORGIT_FZF_DEFAULT_OPTS
        +m -0 --preview=\"$cmd\" --bind=\"enter:execute($cmd |LESS='-R' less)\"
        $FORGIT_DIFF_FZF_OPTS
    "
    eval "yadm diff --name-status $commit -- ${files[*]} | sed 's/^\(.\)[[:space:]]\+\(.*\)$/[\1]  \2/'" |
        FZF_DEFAULT_OPTS="$opts" fzf
}

# git add selector
y_forgit::add() {
    y_forgit::inside_work_tree || return 1
    local changed unmerged untracked files opts
    changed=$(git config --get-color color.status.changed red)
    unmerged=$(git config --get-color color.status.unmerged red)
    untracked=$(git config --get-color color.status.untracked red)

    opts="
        $FORGIT_FZF_DEFAULT_OPTS
        -0 -m --nth 2..,..
        --preview=\"yadm diff --color=always -- {-1} | $forgit_pager\"
        $FORGIT_ADD_FZF_OPTS
    "
    files=$(yadm -c color.status=always -c status.relativePaths=true status --short |
        grep -F -e "$changed" -e "$unmerged" -e "$untracked" |
        sed 's/^\(..[^[:space:]]*\)[[:space:]]\+\(.*\)$/[\1]  \2/' |
        FZF_DEFAULT_OPTS="$opts" fzf | cut -d] -f2 |
        sed 's/.* -> //') # for rename case
    [[ -n "$files" ]] && echo "$files" |xargs -I{} yadm add {} && yadm status --short && return
    echo 'Nothing to add.'
}

# git reset HEAD (unstage) selector
y_forgit::reset::head() {
    y_forgit::inside_work_tree || return 1
    local cmd files opts
    cmd="yadm diff --cached --color=always -- {} | $forgit_pager "
    opts="
        $FORGIT_FZF_DEFAULT_OPTS
        -m -0 --preview=\"$cmd\"
        $FORGIT_RESET_HEAD_FZF_OPTS
    "
    files="$(yadm diff --cached --name-only --relative | FZF_DEFAULT_OPTS="$opts" fzf)"
    [[ -n "$files" ]] && echo "$files" |xargs -I{} yadm reset -q HEAD {} && yadm status --short && return
    echo 'Nothing to unstage.'
}

# git checkout-restore selector
y_forgit::restore() {
    y_forgit::inside_work_tree || return 1
    local cmd files opts
    cmd="yadm diff --color=always -- {} | $forgit_pager"
    opts="
        $FORGIT_FZF_DEFAULT_OPTS
        -m -0 --preview=\"$cmd\"
        $FORGIT_CHECKOUT_FZF_OPTS
    "
    files="$(yadm ls-files --modified "$(yadm rev-parse --show-toplevel)"| FZF_DEFAULT_OPTS="$opts" fzf)"
    [[ -n "$files" ]] && echo "$files" |xargs -I{} yadm checkout {} && yadm status --short && return
    echo 'Nothing to restore.'
}

# git stash viewer
y_forgit::stash::show() {
    y_forgit::inside_work_tree || return 1
    local cmd opts
    cmd="yadm stash show \$(echo {}| cut -d: -f1) --color=always --ext-diff | $forgit_pager"
    opts="
        $FORGIT_FZF_DEFAULT_OPTS
        +s +m -0 --tiebreak=index --preview=\"$cmd\" --bind=\"enter:execute($cmd | LESS='-R' less)\"
        $FORGIT_STASH_FZF_OPTS
    "
    yadm stash list | FZF_DEFAULT_OPTS="$opts" fzf
}

# git clean selector
y_forgit::clean() {
    y_forgit::inside_work_tree || return 1
    local files opts
    opts="
        $FORGIT_FZF_DEFAULT_OPTS
        -m -0
        $FORGIT_CLEAN_FZF_OPTS
    "
    # Note: Postfix '/' in directory path should be removed. Otherwise the directory itself will not be removed.
    files=$(yadm clean -xdfn "$@"| awk '{print $3}'| FZF_DEFAULT_OPTS="$opts" fzf |sed 's#/$##')
    [[ -n "$files" ]] && echo "$files" |xargs -I% yadm clean -xdf % && return
    echo 'Nothing to clean.'
}

# git ignore generator
export FORGIT_GI_REPO_REMOTE=${FORGIT_GI_REPO_REMOTE:-https://github.com/dvcs/gitignore}
export FORGIT_GI_REPO_LOCAL=${FORGIT_GI_REPO_LOCAL:-~/.forgit/gi/repos/dvcs/gitignore}
export FORGIT_GI_TEMPLATES=${FORGIT_GI_TEMPLATES:-$FORGIT_GI_REPO_LOCAL/templates}

y_forgit::ignore() {
    [ -d "$FORGIT_GI_REPO_LOCAL" ] || forgit::ignore::update
    local IFS cmd args cat opts
    # https://github.com/sharkdp/bat.git
    hash bat &>/dev/null && cat='bat -l gitignore --color=always' || cat="cat"
    cmd="$cat $FORGIT_GI_TEMPLATES/{2}{,.gitignore} 2>/dev/null"
    opts="
        $FORGIT_FZF_DEFAULT_OPTS
        -m --preview=\"$cmd\" --preview-window='right:70%'
        $FORGIT_IGNORE_FZF_OPTS
    "
    # shellcheck disable=SC2206,2207
    IFS=$'\n' args=($@) && [[ $# -eq 0 ]] && args=($(y_forgit::ignore::list | nl -nrn -w4 -s'  ' |
        FZF_DEFAULT_OPTS="$opts" fzf  |awk '{print $2}'))
    [ ${#args[@]} -eq 0 ] && return 1
    # shellcheck disable=SC2068
    if hash bat &>/dev/null; then
        y_forgit::ignore::get ${args[@]} | bat -l gitignore
    else
        y_forgit::ignore::get ${args[@]}
    fi
}
y_forgit::ignore::update() {
    if [[ -d "$FORGIT_GI_REPO_LOCAL" ]]; then
        y_forgit::info 'Updating gitignore repo...'
        (cd "$FORGIT_GI_REPO_LOCAL" && git pull --no-rebase --ff) || return 1
    else
        y_forgit::info 'Initializing gitignore repo...'
        git clone --depth=1 "$FORGIT_GI_REPO_REMOTE" "$FORGIT_GI_REPO_LOCAL"
    fi
}
y_forgit::ignore::get() {
    local item filename header
    for item in "$@"; do
        if filename=$(find -L "$FORGIT_GI_TEMPLATES" -type f \( -iname "${item}.gitignore" -o -iname "${item}" \) -print -quit); then
            [[ -z "$filename" ]] && forgit::warn "No gitignore template found for '$item'." && continue
            header="${filename##*/}" && header="${header%.gitignore}"
            echo "### $header" && cat "$filename" && echo
        fi
    done
}
y_forgit::ignore::list() {
    find "$FORGIT_GI_TEMPLATES" -print |sed -e 's#.gitignore$##' -e 's#.*/##' | sort -fu
}
y_forgit::ignore::clean() {
    setopt localoptions rmstarsilent
    [[ -d "$FORGIT_GI_REPO_LOCAL" ]] && rm -rf "$FORGIT_GI_REPO_LOCAL"
}

FORGIT_FZF_DEFAULT_OPTS="
$FZF_DEFAULT_OPTS
--ansi
--height='80%'
--bind='alt-k:preview-up,alt-p:preview-up'
--bind='alt-j:preview-down,alt-n:preview-down'
--bind='ctrl-r:toggle-all'
--bind='ctrl-s:toggle-sort'
--bind='alt-w:toggle-preview-wrap'
--preview-window='right:60%'
$FORGIT_FZF_DEFAULT_OPTS
"

# register aliases
# shellcheck disable=SC2139
alias "y_ga"='y_forgit::add'
alias "y_grh"='y_forgit::reset::head'
alias "y_glo"='y_forgit::log'
alias "y_gd"='y_forgit::diff'
alias "y_gi"='y_forgit::ignore'
alias "y_gcf"='y_forgit::restore'
alias "y_gclean"='y_forgit::clean'
alias "y_gss"='y_forgit::stash::show'

