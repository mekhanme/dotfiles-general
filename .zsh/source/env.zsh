export PAGER="less"
export MANPAGER="most"
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export GO111MODULE="on"
# Editor
if (( ${+commands[micro]} )); then
  export EDITOR='micro'
elif (( ${+commands[nano]} )); then
  export EDITOR='nano'
elif (( ${+commands[vi]} )); then
  export EDITOR='vi'
fi
alias v="$EDITOR"

export LESSCHARSET="UTF-8"
export LESSEDIT="%E ?lm+%lm. %f"
export LESS="-g -i -M -R -S -w -z-4"

export GREP_COLORS='ms=1;35;107'

export TERM="xterm-256color"
export LANG="en_US.utf8"
export LC_CTYPE="en_US.utf8"
export TZ="Europe/Moscow"

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

export HISTSIZE="6000"
export SAVEHIST="${HISTSIZE}"
export HISTFILE="${HOME}/.zhistory"
# export HISTDUP=erase

export GIT_DISCOVERY_ACROSS_FILESYSTEM="1"

export HTTPIE_CONFIG_DIR="${HOME}/.config/httpie"

export ANSIBLE_CONFIG="${HOME}/.ansible/.ansible.cfg"
# ${HOME}/anaconda3/bin:

# https://til.hashrocket.com/posts/7evpdebn7g-remove-duplicates-in-zsh-path
typeset -aU path

# https://github.com/asdf-vm/asdf-nodejs
export NODEJS_CHECK_SIGNATURES=no
export ASDF_SKIP_RESHIM=0

export TENOR_API_KEY="Y7GJ2170KBY9"
export GITHUB_TOKEN="0c32c3199ec6e811b7284c61b6fd54d4532af3fe"
export VULTR_API_KEY="7JC3QKT4D3AOUWUFYHLHTSIXHRHWXO6TFEXA"
export STRAVA_ACCESS_TOKEN="53cd301055d393451f489f10b41527df165872f4"
export STRAVA_REFRESH_TOKEN="778655219781f614789beb1bb87b46ce27f84422"
export STRAVA_CLIENT_SECRET="13f95d23c53862b3f53bbd5f4cf6a8b1dea116b4"
export STRAVA_CLIENT_ID="30937"
export STRAVA_ATHLETE_ID="4741723"
export STRAVA_APP_EXCHANGE_TOKEN="705e797f1bba454ad4a47a465bac78b403a085fb"
export STRAVA_APP_ACCESS_TOKEN="27db7454a46f64aefedd24c3831c24e0ff9afb2f"
export STRAVA_APP_REFRESH_TOKEN="5766c995cbd9ed23e466906f6878a958bd21bff2"
export KOMOOT_USER_ID="916883929714"
export GOOGLE_DRIVE_API_KEY="AIzaSyDzeWI-TB8oxhWD0P_RkR2ypXh9U1oh6PY"
export WEATHERSTACK_API_KEY="5bed3d13228a5b5bef43cae54e5a6fee"
export OPENWEATHERMAP_API_KEY="2f4b76ee52d30f31287abed322f7affb"
export LMS_DEVICE_RADIO="00:04:20:27:f6:f6"

export FD_OPTIONS='--no-ignore --hidden --follow --exclude .git --exclude node_modules --color=always'

export ENHANCD_FILTER="fzf"
export ENHANCD_DISABLE_DOT=0
export ENHANCD_DISABLE_HOME=0
export ENHANCD_DOT_ARG="."

##########
# fzf
##########

# https://www.mankier.com/1/fzf#Key/Event_Bindings-Available_Keys:_(Synonyms)

# https://medium.com/free-code-camp/fzf-a-command-line-fuzzy-finder-missing-demo-a7de312403ff
# Change behavior of fzf dialogue
# https://github.com/junegunn/fzf/wiki/examples
# --bind='f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"

# TODO: починить fd
# fd --no-ignore --hidden --type f --follow --exclude .git --exclude node_modules --color=always | grep '4;38;2;154;237'
# для заметки: важно исключить --color из fzf, чтобы не отображались коды

# поиск из директории git с root
# FZF_COMMAND='if ([ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1); then { git ls-files & git ls-files --others --exclude-standard; }; else find 2>/dev/null; fi'


# export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden"
export FZF_DEFAULT_COMMAND="fd --no-ignore --hidden --type f --follow --exclude .git --exclude node_modules"
# TODO: less не работает
# TODO: tmux load-buffer работает только на tmux хосте
export FZF_DEFAULT_OPTS='
  --header "-> [Ctrl+r] toggle sort <-> [Ctrl+u] wrap lines"
  --prompt "🍧 " --no-height --tiebreak index
  --no-mouse --reverse --multi --layout=default
  --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
  --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
  --bind "ctrl-n:preview-page-down,ctrl-p:preview-page-up"
  --bind "ctrl-space:toggle-preview,ctrl-u:toggle-preview-wrap,ctrl-r:toggle-sort"
  --bind "alt-y:execute-silent(echo {} |tmux load-buffer -b fzf -)"
  --preview "[[ $(file --mime {}) =~ binary ]] &&
                 echo {} is a binary file ||
                 (bat --style=numbers --color=always {} ||
                  cat {}) 2> /dev/null | head -500"
'

# --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
# --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
#   --color fg:124,bg:16,hl:202,fg+:214,bg+:52,hl+:231
#   --color info:52,prompt:196,spinner:208,pointer:196,marker:208

# Use 'git ls-files' when inside GIT repo, or fd otherwise
# export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd --no-ignore --hidden --type f --follow --exclude .git --exclude node_modules  . '/root'"
# TODO: сделать запуск fdr или что-то типа того, cd не работает
export FZF_CTRL_T_OPTS='
  --header "-> [Ctrl+r] toggle sort <-> [Ctrl+u] wrap lines <-> [Alt+m] edit in micro"
  --bind "alt-m:execute(micro {})"
  --bind "alt-l:execute(less -f {})"
'
#  --bind "alt-p:execute(cd $(dirname {}))

export FZF_ALT_C_COMMAND="fd --type d --type l --no-ignore --hidden --follow --exclude .git --exclude node_modules . '/'"

export FZF_ALT_C_OPTS='
  --header "-> [Ctrl+r] toggle sort"
  --prompt "📂 "
  --select-1 --exit-0
  --preview "tree -C {} | head -200"
'

# TODO: сделать с edit-command-line
# сделать копирование через xclip
export FZF_CTRL_R_OPTS='
  --header ""
  --prompt "👀 "
  --preview-window down:10:hidden:wrap
  --preview "echo {}"
'
# --preview-window=down:hidden

# export FZF_COMPLETION_OPTS='+c -x'
export FZF_COMPLETION_OPTS=$FZF_DEFAULT_OPTS
export FZF_COMPLETION_TRIGGER='#'

# время в превью, переделать в ISO
# fc -lf
# history 1938 1948 | bat --style=numbers --color=always -H 5

  # (bat --style=numbers --color=always {} ||
  #                 cat {}) 2> /dev/null | head -500"

# # Integration with ripgrep
# RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
# INITIAL_QUERY="foobar"
# FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
#   fzf --bind "change:reload:$RG_PREFIX {q} || true" \
#       --ansi --phony --query "$INITIAL_QUERY"

# export FZF_TMUX=1
# export FZF_TMUX_HEIGHT=80%
# cat /usr/share/dict/words | fzf-tmux -l 20% --multi --reverse

# Press F1 to open the file with less without leaving fzf
# Press CTRL-Y to copy the line to clipboard and aborts fzf (requires pbcopy)
# fzf --bind 'f1:execute(less -f {}),ctrl-y:execute-silent(echo {} | pbcopy)+abort'

#https://github.com/hzeller/timg
# echo some-image.jpg | fzf --preview='timg -E -f1 -c1 -g $(( $COLUMNS / 2 - 4 ))x$(( $FZF_PREVIEW_HEIGHT * 2 )) {}'

export LFCD="${ZDOTDIR:-$HOME}/functions/lfcd"

export LS_COLORS="or=0;38;2;0;0;0;48;2;255;92;87:*~=0;38;2;102;102;102:fi=0:di=0;38;2;87;199;255:pi=0;38;2;0;0;0;48;2;87;199;255:ex=1;38;2;255;92;87:no=0:ln=0;38;2;255;106;193:mi=0;38;2;0;0;0;48;2;255;92;87:so=0;38;2;0;0;0;48;2;255;106;193:*.z=4;38;2;154;237;254:*.c=0;38;2;90;247;142:*.d=0;38;2;90;247;142:*.r=0;38;2;90;247;142:*.p=0;38;2;90;247;142:*.h=0;38;2;90;247;142:*.t=0;38;2;90;247;142:*.a=1;38;2;255;92;87:*.o=0;38;2;102;102;102:*.m=0;38;2;90;247;142:*css=0;38;2;90;247;142:*.jl=0;38;2;90;247;142:*.cs=0;38;2;90;247;142:*.hh=0;38;2;90;247;142:*.md=0;38;2;243;249;157:*.kt=0;38;2;90;247;142:*.xz=4;38;2;154;237;254:*.ex=0;38;2;90;247;142:*.bz=4;38;2;154;237;254:*.hs=0;38;2;90;247;142:*.fs=0;38;2;90;247;142:*.rm=0;38;2;255;180;223:*.nb=0;38;2;90;247;142:*.cc=0;38;2;90;247;142:*.ps=0;38;2;255;92;87:*.so=1;38;2;255;92;87:*.pp=0;38;2;90;247;142:*.go=0;38;2;90;247;142:*.di=0;38;2;90;247;142:*.as=0;38;2;90;247;142:*.mn=0;38;2;90;247;142:*.cp=0;38;2;90;247;142:*.pl=0;38;2;90;247;142:*.rb=0;38;2;90;247;142:*.rs=0;38;2;90;247;142:*.pm=0;38;2;90;247;142:*.7z=4;38;2;154;237;254:*.js=0;38;2;90;247;142:*.py=0;38;2;90;247;142:*.sh=0;38;2;90;247;142:*.gv=0;38;2;90;247;142:*.el=0;38;2;90;247;142:*.la=0;38;2;102;102;102:*.ml=0;38;2;90;247;142:*.cr=0;38;2;90;247;142:*.lo=0;38;2;102;102;102:*.ui=0;38;2;243;249;157:*.ko=1;38;2;255;92;87:*.gz=4;38;2;154;237;254:*.vb=0;38;2;90;247;142:*.hi=0;38;2;102;102;102:*.ts=0;38;2;90;247;142:*.ttf=0;38;2;255;180;223:*.sty=0;38;2;102;102;102:*.sql=0;38;2;90;247;142:*.m4v=0;38;2;255;180;223:*.rar=4;38;2;154;237;254:*.pro=0;38;2;165;255;195:*.blg=0;38;2;102;102;102:*.bat=1;38;2;255;92;87:*.pdf=0;38;2;255;92;87:*.img=4;38;2;154;237;254:*.pbm=0;38;2;255;180;223:*.pod=0;38;2;90;247;142:*.bin=4;38;2;154;237;254:*.apk=4;38;2;154;237;254:*.svg=0;38;2;255;180;223:*.bmp=0;38;2;255;180;223:*.epp=0;38;2;90;247;142:*.fsx=0;38;2;90;247;142:*.exs=0;38;2;90;247;142:*.fls=0;38;2;102;102;102:*.dmg=4;38;2;154;237;254:*.sxi=0;38;2;255;92;87:*.mp4=0;38;2;255;180;223:*.mpg=0;38;2;255;180;223:*.iso=4;38;2;154;237;254:*.doc=0;38;2;255;92;87:*.mkv=0;38;2;255;180;223:*.tbz=4;38;2;154;237;254:*.dox=0;38;2;165;255;195:*.swp=0;38;2;102;102;102:*.jar=4;38;2;154;237;254:*.xlr=0;38;2;255;92;87:*.tcl=0;38;2;90;247;142:*.exe=1;38;2;255;92;87:*.xcf=0;38;2;255;180;223:*.ltx=0;38;2;90;247;142:*.wmv=0;38;2;255;180;223:*.dot=0;38;2;90;247;142:*.tsx=0;38;2;90;247;142:*.toc=0;38;2;102;102;102:*.ico=0;38;2;255;180;223:*.pyc=0;38;2;102;102;102:*.xmp=0;38;2;243;249;157:*.rst=0;38;2;243;249;157:*.clj=0;38;2;90;247;142:*.hxx=0;38;2;90;247;142:*.otf=0;38;2;255;180;223:*.fnt=0;38;2;255;180;223:*.ipp=0;38;2;90;247;142:*.lua=0;38;2;90;247;142:*.tex=0;38;2;90;247;142:*.h++=0;38;2;90;247;142:*.pas=0;38;2;90;247;142:*.pps=0;38;2;255;92;87:*.kts=0;38;2;90;247;142:*.sxw=0;38;2;255;92;87:*.tar=4;38;2;154;237;254:*.fsi=0;38;2;90;247;142:*.tif=0;38;2;255;180;223:*.tml=0;38;2;243;249;157:*.vob=0;38;2;255;180;223:*.bbl=0;38;2;102;102;102:*.vim=0;38;2;90;247;142:*.ppt=0;38;2;255;92;87:*.deb=4;38;2;154;237;254:*.fon=0;38;2;255;180;223:*.vcd=4;38;2;154;237;254:*.pgm=0;38;2;255;180;223:*.odp=0;38;2;255;92;87:*.ppm=0;38;2;255;180;223:*.yml=0;38;2;243;249;157:*.cxx=0;38;2;90;247;142:*.idx=0;38;2;102;102;102:*.mli=0;38;2;90;247;142:*.dpr=0;38;2;90;247;142:*TODO=1:*.bak=0;38;2;102;102;102:*.dll=1;38;2;255;92;87:*.csv=0;38;2;243;249;157:*.bst=0;38;2;243;249;157:*.sbt=0;38;2;90;247;142:*.nix=0;38;2;243;249;157:*.ps1=0;38;2;90;247;142:*.inl=0;38;2;90;247;142:*.bib=0;38;2;243;249;157:*.cgi=0;38;2;90;247;142:*.log=0;38;2;102;102;102:*.txt=0;38;2;243;249;157:*.ind=0;38;2;102;102;102:*.ilg=0;38;2;102;102;102:*.out=0;38;2;102;102;102:*.bz2=4;38;2;154;237;254:*.zsh=0;38;2;90;247;142:*.xls=0;38;2;255;92;87:*.csx=0;38;2;90;247;142:*.rpm=4;38;2;154;237;254:*.pkg=4;38;2;154;237;254:*.htm=0;38;2;243;249;157:*.tmp=0;38;2;102;102;102:*.ics=0;38;2;255;92;87:*.cpp=0;38;2;90;247;142:*.xml=0;38;2;243;249;157:*.erl=0;38;2;90;247;142:*hgrc=0;38;2;165;255;195:*.c++=0;38;2;90;247;142:*.bcf=0;38;2;102;102;102:*.avi=0;38;2;255;180;223:*.png=0;38;2;255;180;223:*.bag=4;38;2;154;237;254:*.asa=0;38;2;90;247;142:*.com=1;38;2;255;92;87:*.php=0;38;2;90;247;142:*.odt=0;38;2;255;92;87:*.mid=0;38;2;255;180;223:*.kex=0;38;2;255;92;87:*.zip=4;38;2;154;237;254:*.awk=0;38;2;90;247;142:*.aif=0;38;2;255;180;223:*.ogg=0;38;2;255;180;223:*.jpg=0;38;2;255;180;223:*.pid=0;38;2;102;102;102:*.gif=0;38;2;255;180;223:*.mov=0;38;2;255;180;223:*.swf=0;38;2;255;180;223:*.aux=0;38;2;102;102;102:*.wma=0;38;2;255;180;223:*.flv=0;38;2;255;180;223:*.ini=0;38;2;243;249;157:*.tgz=4;38;2;154;237;254:*.arj=4;38;2;154;237;254:*.gvy=0;38;2;90;247;142:*.bsh=0;38;2;90;247;142:*.wav=0;38;2;255;180;223:*.htc=0;38;2;90;247;142:*.git=0;38;2;102;102;102:*.ods=0;38;2;255;92;87:*.rtf=0;38;2;255;92;87:*.hpp=0;38;2;90;247;142:*.cfg=0;38;2;243;249;157:*.elm=0;38;2;90;247;142:*.mp3=0;38;2;255;180;223:*.fish=0;38;2;90;247;142:*.hgrc=0;38;2;165;255;195:*.dart=0;38;2;90;247;142:*.orig=0;38;2;102;102;102:*.conf=0;38;2;243;249;157:*.lock=0;38;2;102;102;102:*.java=0;38;2;90;247;142:*.epub=0;38;2;255;92;87:*.json=0;38;2;243;249;157:*.tbz2=4;38;2;154;237;254:*.psm1=0;38;2;90;247;142:*.docx=0;38;2;255;92;87:*.jpeg=0;38;2;255;180;223:*.flac=0;38;2;255;180;223:*.less=0;38;2;90;247;142:*.xlsx=0;38;2;255;92;87:*.diff=0;38;2;90;247;142:*.purs=0;38;2;90;247;142:*.toml=0;38;2;243;249;157:*.mpeg=0;38;2;255;180;223:*.yaml=0;38;2;243;249;157:*.rlib=0;38;2;102;102;102:*.html=0;38;2;243;249;157:*.psd1=0;38;2;90;247;142:*.bash=0;38;2;90;247;142:*.lisp=0;38;2;90;247;142:*.pptx=0;38;2;255;92;87:*.make=0;38;2;165;255;195:*.h264=0;38;2;255;180;223:*README=0;38;2;40;42;54;48;2;243;249;157:*.mdown=0;38;2;243;249;157:*.patch=0;38;2;90;247;142:*.toast=4;38;2;154;237;254:*.swift=0;38;2;90;247;142:*.cache=0;38;2;102;102;102:*.scala=0;38;2;90;247;142:*.shtml=0;38;2;243;249;157:*shadow=0;38;2;243;249;157:*.dyn_o=0;38;2;102;102;102:*.class=0;38;2;102;102;102:*.xhtml=0;38;2;243;249;157:*.cmake=0;38;2;165;255;195:*passwd=0;38;2;243;249;157:*.cabal=0;38;2;90;247;142:*.ipynb=0;38;2;90;247;142:*.config=0;38;2;243;249;157:*TODO.md=1:*COPYING=0;38;2;153;153;153:*INSTALL=0;38;2;40;42;54;48;2;243;249;157:*.flake8=0;38;2;165;255;195:*.ignore=0;38;2;165;255;195:*.dyn_hi=0;38;2;102;102;102:*.gradle=0;38;2;90;247;142:*LICENSE=0;38;2;153;153;153:*.matlab=0;38;2;90;247;142:*.groovy=0;38;2;90;247;142:*.desktop=0;38;2;243;249;157:*TODO.txt=1:*Makefile=0;38;2;165;255;195:*Doxyfile=0;38;2;165;255;195:*setup.py=0;38;2;165;255;195:*.gemspec=0;38;2;165;255;195:*COPYRIGHT=0;38;2;153;153;153:*.cmake.in=0;38;2;165;255;195:*.markdown=0;38;2;243;249;157:*.kdevelop=0;38;2;165;255;195:*.fdignore=0;38;2;165;255;195:*.rgignore=0;38;2;165;255;195:*configure=0;38;2;165;255;195:*README.md=0;38;2;40;42;54;48;2;243;249;157:*README.txt=0;38;2;40;42;54;48;2;243;249;157:*CODEOWNERS=0;38;2;165;255;195:*.gitconfig=0;38;2;165;255;195:*SConscript=0;38;2;165;255;195:*.gitignore=0;38;2;165;255;195:*.scons_opt=0;38;2;102;102;102:*INSTALL.md=0;38;2;40;42;54;48;2;243;249;157:*Dockerfile=0;38;2;243;249;157:*SConstruct=0;38;2;165;255;195:*MANIFEST.in=0;38;2;165;255;195:*.gitmodules=0;38;2;165;255;195:*LICENSE-MIT=0;38;2;153;153;153:*Makefile.am=0;38;2;165;255;195:*.travis.yml=0;38;2;90;247;142:*.synctex.gz=0;38;2;102;102;102:*Makefile.in=0;38;2;102;102;102:*CONTRIBUTORS=0;38;2;40;42;54;48;2;243;249;157:*appveyor.yml=0;38;2;90;247;142:*configure.ac=0;38;2;165;255;195:*.fdb_latexmk=0;38;2;102;102;102:*.applescript=0;38;2;90;247;142:*.clang-format=0;38;2;165;255;195:*LICENSE-APACHE=0;38;2;153;153;153:*CMakeCache.txt=0;38;2;102;102;102:*.gitattributes=0;38;2;165;255;195:*CMakeLists.txt=0;38;2;165;255;195:*INSTALL.md.txt=0;38;2;40;42;54;48;2;243;249;157:*CONTRIBUTORS.md=0;38;2;40;42;54;48;2;243;249;157:*.sconsign.dblite=0;38;2;102;102;102:*CONTRIBUTORS.txt=0;38;2;40;42;54;48;2;243;249;157:*requirements.txt=0;38;2;165;255;195:*package-lock.json=0;38;2;102;102;102"