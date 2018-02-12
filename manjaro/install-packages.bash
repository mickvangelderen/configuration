sudo --verify || exit 1

sudo pacman -Syy
sudo pacman -S --noconfirm yaourt vim git emacs
yaourt -S --noconfirm google-chrome vscode dropbox
