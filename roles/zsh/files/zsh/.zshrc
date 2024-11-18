# Set XDG base dirs.
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}

# Ensure XDG dirs exist.
for xdgdir in XDG_{CONFIG,CACHE,DATA,STATE}_HOME XDG_RUNTIME_DIR; do
  [[ -e ${(P)xdgdir} ]] || mkdir -p ${(P)xdgdir}
done

# OS specific
if [[ "$OSTYPE" == darwin* ]]; then
  export XDG_DESKTOP_DIR=${XDG_DESKTOP_DIR:-$HOME/Desktop}
  export XDG_DOCUMENTS_DIR=${XDG_DOCUMENTS_DIR:-$HOME/Documents}
  export XDG_DOWNLOAD_DIR=${XDG_DOWNLOAD_DIR:-$HOME/Downloads}
  export XDG_MUSIC_DIR=${XDG_MUSIC_DIR:-$HOME/Music}
  export XDG_PICTURES_DIR=${XDG_PICTURES_DIR:-$HOME/Pictures}
  export XDG_VIDEOS_DIR=${XDG_VIDEOS_DIR:-$HOME/Videos}
  export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/Projects}
fi

stty -ixon

# export FZF_PATH=${XDG_CONFIG_HOME}/fzf

#
# Common
#


# Load zprof first if we need to profile.
[[ -z "$ZPROFRC" ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

setopt always_to_end
setopt append_history
setopt complete_in_word
setopt extended_history
setopt extendedglob
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt inc_append_history_time
setopt interactive_comments
setopt nomatch
setopt share_history

zle_highlight=('paste:none')

# Disable Ctrl-s to freeze terminal
# stty stop undef

# Turn off all beeps
unsetopt BEEP
# Turn off autocomplete beeps
# unsetopt LIST_BEEP

# Enable vi mode
bindkey -v

for file in $HOME/.config/zsh/.zsh_*; do
  source "$file"
done

# if [[ -f "$HOME/.config/zsh/.zsh_private" ]]; then
#     source "$HOME/.config/zsh/.zsh_private"
# fi

for file in $HOME/.config/zsh/*.zsh; do
  source "$file"
done

# source $ZDOTDIR/.zfunctions

# # zexports config
# zsh_add_file ".zexports"
# # zstyle config
# zsh_add_file ".zstyles"
# # zplugins config
# zsh_add_file ".zplugins"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# export ZSH="$HOME/.config/zsh/ohmyzsh"

source $ZSH/oh-my-zsh.sh

# zaliases config
# zsh_add_file ".zaliases"

setup_ssh_agent

# Done profiling.
[[ -z "$ZPROFRC" ]] || zprof
unset ZPROFRC
true

[[ -f $ZDOTDIR/.zshrc_local ]] && $ZDOTDIR/.zshrc_local


