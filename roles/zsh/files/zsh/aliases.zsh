#!/usr/bin/env zsh

function display_path() {
  path_name=$1
  echo -e ${path_name//:/\\n}
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls="ls --color=auto"
  alias grep="grep --color=auto"
  alias egrep="egrep --color=auto"
  alias fgrep="fgrep --color=auto"
fi

alias cp="cp -i"
alias df="df -kTh"
alias dirsize="find . -maxdepth 1 -type d 2>/dev/null | xargs du -hs 2>/dev/null"
alias du="du -ckh --max-depth=1 2>/dev/null | sort -h"
alias empty="rm --recursive --verbose --force ~/.local/share/Trash/files/*"
alias free='free -m'                      # show sizes in MB
alias h="history"
alias j="jobs -l"
alias la="ls -hvA --classify --color=auto --group-directories-first"
alias ll="ls -lhv --classify --color=auto --group-directories-first"
alias lla="ls -lhvA --classify --color=auto --group-directories-first"
alias lr="ls -lRthv --classify --color=auto --group-directories-first"
alias lrt="ls -lrth --classify --color=auto --group-directories-first"
alias ls="ls -h --classify --color=auto --group-directories-first"
alias lsr="ls -lSrth --classify --color=auto --group-directories-first"
alias more="less"
alias mkdir="mkdir -p"
alias mv="mv -i"
# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'
alias rm="rm -i"
alias rsync="rsync --progress"
alias tree="tree -Csuh"
alias which="type -a"

alias path="display_path $PATH"
alias libpath="display_path  $LS_LIBRARY_PATH"


# alias dvolumes='docker ps -a --format "{{ .ID }}" | xargs -I {} docker inspect --format="{{ .Name }}{{ printf \"\n\" }}{{ range .Mounts }}{{ printf \"\n\t\" }}{{ .Type }} {{ if eq .Type \"bind\" }}{{ .Source }}{{ end }}{{ .Name }} => {{ .Destination }}{{ end }}{{ printf \"\n\" }}" {}'

# alias dports='docker ps -a --format "{{ .ID }}" | xargs -I {} docker inspect --format="{{ .Name }}{{ printf \"\n\" }}{{ range \$p, \$conf := .NetworkSettings.Ports }}{{ printf \"\n\t\" }}{{ \$p }} => {{ (index \$conf 0).HostIp }}{{printf \":\" }}{{ (index \$conf 0).HostPort }}{{ end }}{{ printf \"\n\" }}" {}'
# alias dpc="docker rm $(docker ps -aq)"

alias npm-install="NODE_TLS_REJECT_UNAUTHORIZED=0 npm install"
alias npm-tree="npm ls --all"

# systemd
alias list_systemctl="systemctl list-unit-files --state=enabled"
