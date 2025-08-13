#!/usr/bin/env bash
set -e

DOTFILES_REPO="https://github.com/USERNAME/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"
PKGLIST_FILE="$DOTFILES_DIR/pkglist.txt"

if [[ $EUID -eq 0 ]]; then
    echo "Do not run as root"
    exit 1
fi

sudo pacman -S --needed base-devel git stow curl

if ! command -v yay &>/dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
fi

if [[ ! -d "$DOTFILES_DIR" ]]; then
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
    git -C "$DOTFILES_DIR" pull
fi

if [[ -f "$PKGLIST_FILE" ]]; then
    yay -S --needed - < "$PKGLIST_FILE"
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

cd "$DOTFILES_DIR"
stow */

