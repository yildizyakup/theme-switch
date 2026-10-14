#!/usr/bin/env bash
# Link theme-switch and its themes into place for the current user.
# Re-running is safe; existing files/folders that aren't links yet are backed up first.
set -euo pipefail

HERE=$(cd "$(dirname "$0")" && pwd)
# Backups go to one place, not next to the originals
BACKUP=$HOME/.local/state/theme-switch/backup-$(date +%Y%m%d-%H%M%S)

link() {  # link <target> <link-path>: move a real file/dir into $BACKUP, then symlink
    local target=$1 path=$2
    mkdir -p "$(dirname "$path")"
    if [ -e "$path" ] && [ ! -L "$path" ]; then
        mkdir -p "$BACKUP"
        mv "$path" "$BACKUP/"
        echo "Backed up $path → $BACKUP/"
    fi
    ln -sfn "$target" "$path"
}

missing=()
for cmd in zenity notify-send gsettings python3; do
    command -v "$cmd" >/dev/null || missing+=("$cmd")
done
if [ ${#missing[@]} -gt 0 ]; then
    echo "Missing commands: ${missing[*]} (sudo apt install zenity libnotify-bin)" >&2
    exit 1
fi

link "$HERE/theme-switch" "$HOME/.local/bin/theme-switch"
link "$HERE/themes" "$HOME/.config/theme-switcher/themes"

if [ ! -f "$HOME/.config/starship.toml" ]; then
    cp "$HERE/starship/starship.toml" "$HOME/.config/starship.toml"
    echo "Installed starship.toml with all palettes."
elif ! grep -q '^\[palettes\.gruvbox_material\]' "$HOME/.config/starship.toml"; then
    echo "Note: add the [palettes.*] sections from starship/starship.toml to your ~/.config/starship.toml."
fi

echo "Done. Run 'theme-switch' to pick a theme, or 'theme-switch gruvbox' to apply one directly."
