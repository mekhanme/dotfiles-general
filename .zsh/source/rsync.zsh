# https://github.com/sorin-ionescu/prezto/blob/master/modules/rsync/init.zsh

_rsync_cmd='rsync --verbose --progress --human-readable --compress --archive \
  --hard-links --one-file-system'

if grep -q 'xattrs' <(rsync --help 2>&1); then
  _rsync_cmd="${_rsync_cmd} --acls --xattrs"
fi

# macOS and HFS+ Enhancements
# https://bombich.com/kb/ccc5/credits
if [[ "$OSTYPE" == darwin* ]] && grep -q 'file-flags' <(rsync --help 2>&1); then
  _rsync_cmd="${_rsync_cmd} --crtimes --fileflags --protect-decmpfs --force-change"
fi

alias rsync-copy="${_rsync_cmd}"
alias rsync-move="${_rsync_cmd} --remove-source-files"
alias rsync-update="${_rsync_cmd} --update"
alias rsync-synchronize="${_rsync_cmd} --update --delete"

unset _rsync_cmd