#!/usr/bin/env zsh

export SSH_ENV=$HOME/.ssh/environment

function start_agent() {
  # echo "Initialising new SSH agent..."

  eval `/usr/bin/ssh-agent` 2>/dev/null
  env | grep SSH_AUTH_SOCK | awk '{ print $1"; export SSH_AUTH_SOCK;" }' >> ${SSH_ENV}.tmp
  env | grep SSH_AGENT_PID | awk '{ print $1"; export SSH_AGENT_PID;" }' >> ${SSH_ENV}.tmp
  mv -f ${SSH_ENV}.tmp ${SSH_ENV}

  # echo "Succeeded"
  chmod 600 ${SSH_ENV}
  . ${SSH_ENV}

  /usr/bin/ssh-add 2>/dev/null
}

function setup_ssh_agent() {
  if [ -f "${SSH_ENV}" ]; then
    . ${SSH_ENV} > /dev/null

    ps -ef | grep ${SSH_AGENT_PID} | grep -v grep | grep ssh-agent > /dev/null || {
      start_agent;
    }
  else
    start_agent;
  fi
}