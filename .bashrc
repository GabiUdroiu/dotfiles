#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export HYPRLAND_CONFIG_DIR="$HOME=/.config/hypr"

alias dockerstart='sudo systemctl start docker'
alias dockerstop='sudo systemctl stop docker'
export VCPKG_ROOT=$HOME/vcpkg
. "$HOME/.cargo/env"
