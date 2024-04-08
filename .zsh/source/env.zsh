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

# https://til.hashrocket.com/posts/7evpdebn7g-remove-duplicates-in-zsh-path
typeset -aU path

export FD_OPTIONS='--no-ignore --hidden --follow --exclude .git --exclude node_modules --color=always'

export ENHANCD_FILTER="fzf"
export ENHANCD_DISABLE_DOT=0
export ENHANCD_DISABLE_HOME=0
export ENHANCD_DOT_ARG="."


export LFCD="${ZDOTDIR:-$HOME}/functions/lfcd"

export LS_COLORS="or=0;38;2;0;0;0;48;2;255;92;87:*~=0;38;2;102;102;102:fi=0:di=0;38;2;87;199;255:pi=0;38;2;0;0;0;48;2;87;199;255:ex=1;38;2;255;92;87:no=0:ln=0;38;2;255;106;193:mi=0;38;2;0;0;0;48;2;255;92;87:so=0;38;2;0;0;0;48;2;255;106;193:*.z=4;38;2;154;237;254:*.c=0;38;2;90;247;142:*.d=0;38;2;90;247;142:*.r=0;38;2;90;247;142:*.p=0;38;2;90;247;142:*.h=0;38;2;90;247;142:*.t=0;38;2;90;247;142:*.a=1;38;2;255;92;87:*.o=0;38;2;102;102;102:*.m=0;38;2;90;247;142:*css=0;38;2;90;247;142:*.jl=0;38;2;90;247;142:*.cs=0;38;2;90;247;142:*.hh=0;38;2;90;247;142:*.md=0;38;2;243;249;157:*.kt=0;38;2;90;247;142:*.xz=4;38;2;154;237;254:*.ex=0;38;2;90;247;142:*.bz=4;38;2;154;237;254:*.hs=0;38;2;90;247;142:*.fs=0;38;2;90;247;142:*.rm=0;38;2;255;180;223:*.nb=0;38;2;90;247;142:*.cc=0;38;2;90;247;142:*.ps=0;38;2;255;92;87:*.so=1;38;2;255;92;87:*.pp=0;38;2;90;247;142:*.go=0;38;2;90;247;142:*.di=0;38;2;90;247;142:*.as=0;38;2;90;247;142:*.mn=0;38;2;90;247;142:*.cp=0;38;2;90;247;142:*.pl=0;38;2;90;247;142:*.rb=0;38;2;90;247;142:*.rs=0;38;2;90;247;142:*.pm=0;38;2;90;247;142:*.7z=4;38;2;154;237;254:*.js=0;38;2;90;247;142:*.py=0;38;2;90;247;142:*.sh=0;38;2;90;247;142:*.gv=0;38;2;90;247;142:*.el=0;38;2;90;247;142:*.la=0;38;2;102;102;102:*.ml=0;38;2;90;247;142:*.cr=0;38;2;90;247;142:*.lo=0;38;2;102;102;102:*.ui=0;38;2;243;249;157:*.ko=1;38;2;255;92;87:*.gz=4;38;2;154;237;254:*.vb=0;38;2;90;247;142:*.hi=0;38;2;102;102;102:*.ts=0;38;2;90;247;142:*.ttf=0;38;2;255;180;223:*.sty=0;38;2;102;102;102:*.sql=0;38;2;90;247;142:*.m4v=0;38;2;255;180;223:*.rar=4;38;2;154;237;254:*.pro=0;38;2;165;255;195:*.blg=0;38;2;102;102;102:*.bat=1;38;2;255;92;87:*.pdf=0;38;2;255;92;87:*.img=4;38;2;154;237;254:*.pbm=0;38;2;255;180;223:*.pod=0;38;2;90;247;142:*.bin=4;38;2;154;237;254:*.apk=4;38;2;154;237;254:*.svg=0;38;2;255;180;223:*.bmp=0;38;2;255;180;223:*.epp=0;38;2;90;247;142:*.fsx=0;38;2;90;247;142:*.exs=0;38;2;90;247;142:*.fls=0;38;2;102;102;102:*.dmg=4;38;2;154;237;254:*.sxi=0;38;2;255;92;87:*.mp4=0;38;2;255;180;223:*.mpg=0;38;2;255;180;223:*.iso=4;38;2;154;237;254:*.doc=0;38;2;255;92;87:*.mkv=0;38;2;255;180;223:*.tbz=4;38;2;154;237;254:*.dox=0;38;2;165;255;195:*.swp=0;38;2;102;102;102:*.jar=4;38;2;154;237;254:*.xlr=0;38;2;255;92;87:*.tcl=0;38;2;90;247;142:*.exe=1;38;2;255;92;87:*.xcf=0;38;2;255;180;223:*.ltx=0;38;2;90;247;142:*.wmv=0;38;2;255;180;223:*.dot=0;38;2;90;247;142:*.tsx=0;38;2;90;247;142:*.toc=0;38;2;102;102;102:*.ico=0;38;2;255;180;223:*.pyc=0;38;2;102;102;102:*.xmp=0;38;2;243;249;157:*.rst=0;38;2;243;249;157:*.clj=0;38;2;90;247;142:*.hxx=0;38;2;90;247;142:*.otf=0;38;2;255;180;223:*.fnt=0;38;2;255;180;223:*.ipp=0;38;2;90;247;142:*.lua=0;38;2;90;247;142:*.tex=0;38;2;90;247;142:*.h++=0;38;2;90;247;142:*.pas=0;38;2;90;247;142:*.pps=0;38;2;255;92;87:*.kts=0;38;2;90;247;142:*.sxw=0;38;2;255;92;87:*.tar=4;38;2;154;237;254:*.fsi=0;38;2;90;247;142:*.tif=0;38;2;255;180;223:*.tml=0;38;2;243;249;157:*.vob=0;38;2;255;180;223:*.bbl=0;38;2;102;102;102:*.vim=0;38;2;90;247;142:*.ppt=0;38;2;255;92;87:*.deb=4;38;2;154;237;254:*.fon=0;38;2;255;180;223:*.vcd=4;38;2;154;237;254:*.pgm=0;38;2;255;180;223:*.odp=0;38;2;255;92;87:*.ppm=0;38;2;255;180;223:*.yml=0;38;2;243;249;157:*.cxx=0;38;2;90;247;142:*.idx=0;38;2;102;102;102:*.mli=0;38;2;90;247;142:*.dpr=0;38;2;90;247;142:*TODO=1:*.bak=0;38;2;102;102;102:*.dll=1;38;2;255;92;87:*.csv=0;38;2;243;249;157:*.bst=0;38;2;243;249;157:*.sbt=0;38;2;90;247;142:*.nix=0;38;2;243;249;157:*.ps1=0;38;2;90;247;142:*.inl=0;38;2;90;247;142:*.bib=0;38;2;243;249;157:*.cgi=0;38;2;90;247;142:*.log=0;38;2;102;102;102:*.txt=0;38;2;243;249;157:*.ind=0;38;2;102;102;102:*.ilg=0;38;2;102;102;102:*.out=0;38;2;102;102;102:*.bz2=4;38;2;154;237;254:*.zsh=0;38;2;90;247;142:*.xls=0;38;2;255;92;87:*.csx=0;38;2;90;247;142:*.rpm=4;38;2;154;237;254:*.pkg=4;38;2;154;237;254:*.htm=0;38;2;243;249;157:*.tmp=0;38;2;102;102;102:*.ics=0;38;2;255;92;87:*.cpp=0;38;2;90;247;142:*.xml=0;38;2;243;249;157:*.erl=0;38;2;90;247;142:*hgrc=0;38;2;165;255;195:*.c++=0;38;2;90;247;142:*.bcf=0;38;2;102;102;102:*.avi=0;38;2;255;180;223:*.png=0;38;2;255;180;223:*.bag=4;38;2;154;237;254:*.asa=0;38;2;90;247;142:*.com=1;38;2;255;92;87:*.php=0;38;2;90;247;142:*.odt=0;38;2;255;92;87:*.mid=0;38;2;255;180;223:*.kex=0;38;2;255;92;87:*.zip=4;38;2;154;237;254:*.awk=0;38;2;90;247;142:*.aif=0;38;2;255;180;223:*.ogg=0;38;2;255;180;223:*.jpg=0;38;2;255;180;223:*.pid=0;38;2;102;102;102:*.gif=0;38;2;255;180;223:*.mov=0;38;2;255;180;223:*.swf=0;38;2;255;180;223:*.aux=0;38;2;102;102;102:*.wma=0;38;2;255;180;223:*.flv=0;38;2;255;180;223:*.ini=0;38;2;243;249;157:*.tgz=4;38;2;154;237;254:*.arj=4;38;2;154;237;254:*.gvy=0;38;2;90;247;142:*.bsh=0;38;2;90;247;142:*.wav=0;38;2;255;180;223:*.htc=0;38;2;90;247;142:*.git=0;38;2;102;102;102:*.ods=0;38;2;255;92;87:*.rtf=0;38;2;255;92;87:*.hpp=0;38;2;90;247;142:*.cfg=0;38;2;243;249;157:*.elm=0;38;2;90;247;142:*.mp3=0;38;2;255;180;223:*.fish=0;38;2;90;247;142:*.hgrc=0;38;2;165;255;195:*.dart=0;38;2;90;247;142:*.orig=0;38;2;102;102;102:*.conf=0;38;2;243;249;157:*.lock=0;38;2;102;102;102:*.java=0;38;2;90;247;142:*.epub=0;38;2;255;92;87:*.json=0;38;2;243;249;157:*.tbz2=4;38;2;154;237;254:*.psm1=0;38;2;90;247;142:*.docx=0;38;2;255;92;87:*.jpeg=0;38;2;255;180;223:*.flac=0;38;2;255;180;223:*.less=0;38;2;90;247;142:*.xlsx=0;38;2;255;92;87:*.diff=0;38;2;90;247;142:*.purs=0;38;2;90;247;142:*.toml=0;38;2;243;249;157:*.mpeg=0;38;2;255;180;223:*.yaml=0;38;2;243;249;157:*.rlib=0;38;2;102;102;102:*.html=0;38;2;243;249;157:*.psd1=0;38;2;90;247;142:*.bash=0;38;2;90;247;142:*.lisp=0;38;2;90;247;142:*.pptx=0;38;2;255;92;87:*.make=0;38;2;165;255;195:*.h264=0;38;2;255;180;223:*README=0;38;2;40;42;54;48;2;243;249;157:*.mdown=0;38;2;243;249;157:*.patch=0;38;2;90;247;142:*.toast=4;38;2;154;237;254:*.swift=0;38;2;90;247;142:*.cache=0;38;2;102;102;102:*.scala=0;38;2;90;247;142:*.shtml=0;38;2;243;249;157:*shadow=0;38;2;243;249;157:*.dyn_o=0;38;2;102;102;102:*.class=0;38;2;102;102;102:*.xhtml=0;38;2;243;249;157:*.cmake=0;38;2;165;255;195:*passwd=0;38;2;243;249;157:*.cabal=0;38;2;90;247;142:*.ipynb=0;38;2;90;247;142:*.config=0;38;2;243;249;157:*TODO.md=1:*COPYING=0;38;2;153;153;153:*INSTALL=0;38;2;40;42;54;48;2;243;249;157:*.flake8=0;38;2;165;255;195:*.ignore=0;38;2;165;255;195:*.dyn_hi=0;38;2;102;102;102:*.gradle=0;38;2;90;247;142:*LICENSE=0;38;2;153;153;153:*.matlab=0;38;2;90;247;142:*.groovy=0;38;2;90;247;142:*.desktop=0;38;2;243;249;157:*TODO.txt=1:*Makefile=0;38;2;165;255;195:*Doxyfile=0;38;2;165;255;195:*setup.py=0;38;2;165;255;195:*.gemspec=0;38;2;165;255;195:*COPYRIGHT=0;38;2;153;153;153:*.cmake.in=0;38;2;165;255;195:*.markdown=0;38;2;243;249;157:*.kdevelop=0;38;2;165;255;195:*.fdignore=0;38;2;165;255;195:*.rgignore=0;38;2;165;255;195:*configure=0;38;2;165;255;195:*README.md=0;38;2;40;42;54;48;2;243;249;157:*README.txt=0;38;2;40;42;54;48;2;243;249;157:*CODEOWNERS=0;38;2;165;255;195:*.gitconfig=0;38;2;165;255;195:*SConscript=0;38;2;165;255;195:*.gitignore=0;38;2;165;255;195:*.scons_opt=0;38;2;102;102;102:*INSTALL.md=0;38;2;40;42;54;48;2;243;249;157:*Dockerfile=0;38;2;243;249;157:*SConstruct=0;38;2;165;255;195:*MANIFEST.in=0;38;2;165;255;195:*.gitmodules=0;38;2;165;255;195:*LICENSE-MIT=0;38;2;153;153;153:*Makefile.am=0;38;2;165;255;195:*.travis.yml=0;38;2;90;247;142:*.synctex.gz=0;38;2;102;102;102:*Makefile.in=0;38;2;102;102;102:*CONTRIBUTORS=0;38;2;40;42;54;48;2;243;249;157:*appveyor.yml=0;38;2;90;247;142:*configure.ac=0;38;2;165;255;195:*.fdb_latexmk=0;38;2;102;102;102:*.applescript=0;38;2;90;247;142:*.clang-format=0;38;2;165;255;195:*LICENSE-APACHE=0;38;2;153;153;153:*CMakeCache.txt=0;38;2;102;102;102:*.gitattributes=0;38;2;165;255;195:*CMakeLists.txt=0;38;2;165;255;195:*INSTALL.md.txt=0;38;2;40;42;54;48;2;243;249;157:*CONTRIBUTORS.md=0;38;2;40;42;54;48;2;243;249;157:*.sconsign.dblite=0;38;2;102;102;102:*CONTRIBUTORS.txt=0;38;2;40;42;54;48;2;243;249;157:*requirements.txt=0;38;2;165;255;195:*package-lock.json=0;38;2;102;102;102"