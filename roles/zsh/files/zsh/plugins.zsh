#!/usr/bin/env zsh

#
# .zplugins - plugins file
#

#plugins=(copybuffer copyfile copypath dirhistory docker extract git git-extras sudo yum zsh-256color zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting zsh-vi-mode)

plugins+=()
plugins+=(copybuffer)
plugins+=(copyfile)
plugins+=(copypath)
plugins+=(dirhistory)
plugins+=(docker)
plugins+=(extract)
plugins+=(git)
plugins+=(git-extras)
plugins+=(sudo)
plugins+=(yum)

# Custom plugins
plugins+=(zsh-256color)
plugins+=(zsh-autosuggestions)
plugins+=(zsh-history-substring-search)
plugins+=(zsh-syntax-highlighting)


fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

rm -f $ZDOTDIR/.zcompdump*;
autoload -U compinit && compinit

# history substring search options
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down