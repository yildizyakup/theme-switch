# theme-switch

Switch your whole Linux Mint Cinnamon desktop between color themes with one command or one shortcut: the GTK and window theme, the panel, icons, the Plank dock, kitty, the Starship prompt, VS Code and cava all change together.

```bash
theme-switch              # pick a theme from a list
theme-switch gruvbox      # apply one directly
```

## What changes

| Part | How |
|---|---|
| GTK apps, Cinnamon panel, window borders | `gsettings` (Cinnamon + GNOME keys) |
| GTK4 / libadwaita apps | links the theme's `gtk-4.0` files into `~/.config/gtk-4.0` |
| Icons | `gsettings` icon theme |
| Plank dock | `gsettings` dock theme |
| kitty | rewrites `current-theme.conf` and `dark-theme.auto.conf`, reloads running windows (`SIGUSR1`) |
| Starship | switches `palette = …` in `starship.toml` (all palettes share color names) |
| VS Code | sets `workbench.colorTheme` in `settings.json`, applied live |
| cava | replaces the `[color]` section and reloads running instances (`SIGUSR2`) |

## Themes

| id | Name | GTK theme | Icons | VS Code |
|---|---|---|---|---|
| `gruvbox` | Gruvbox Material Dark | Gruvbox-Orange-Dark | Mint-L-Orange | Gruvbox Dark Hard (`jdinhlife.gruvbox`) |
| `catppuccin` | Catppuccin Mocha (grey) | Catppuccin-Grey-Dark | Mint-L-Grey | Catppuccin Mocha (`Catppuccin.catppuccin-vsc`) |
| `tokyonight` | Tokyo Night Storm | Tokyonight-Dark-Storm | Mint-L-Blue | Tokyo Night Storm (`enkia.tokyo-night`) |
| `everforest` | Everforest Dark | Everforest-Green-Dark | Mint-L | Everforest Dark (`sainnhe.everforest`) |
| `carbonfox` | Carbonfox | Nightfox-Dark-Carbonfox | Mint-L-Grey | Default Dark Modern (built in) |
| `osaka` | Solarized Osaka | Osaka-Teal-Dark | Mint-L-Teal | Solarized Osaka (`sherloach.solarized-osaka`) |
| `material` | Material Darker | Material-Dark-Darker | Mint-L-Aqua | Default Dark Modern (built in) |

The GTK themes come from [Fausto-Korpsvart](https://github.com/Fausto-Korpsvart)'s repositories ([Gruvbox](https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme), [Catppuccin](https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme), [Tokyonight](https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme), [Everforest](https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme), [Nightfox](https://github.com/Fausto-Korpsvart/Nightfox-GTK-Theme), [Osaka](https://github.com/Fausto-Korpsvart/Osaka-GTK-Theme), [Material](https://github.com/Fausto-Korpsvart/Material-GTK-Themes)); install the ones you want with each repo's own install script. The Mint-L icon themes ship with Linux Mint.

## Install

```bash
sudo apt install zenity libnotify-bin
git clone https://github.com/yildizyakup/theme-switch.git
cd theme-switch
./install.sh
```

`install.sh` symlinks the script into `~/.local/bin`, the themes into `~/.config/theme-switcher/themes` and the Plank dock themes into `~/.local/share/plank/themes`, so `git pull` updates everything in place. Existing files and folders are moved to `~/.local/state/theme-switch/` first, not overwritten. If you don't have a `~/.config/starship.toml` yet, it installs the included one; otherwise copy its `[palettes.*]` sections into yours.

**Keyboard shortcut:** System Settings → Keyboard → Shortcuts → Custom Shortcuts → *Add*, command `theme-switch`, for example on <kbd>Super</kbd>+<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Space</kbd>.

## Adding a theme

Create `themes/<id>/` with:

- `theme.env` — `NAME`, `GTK_THEME`, `ICON_THEME`, `PLANK_THEME`, `VSCODE_THEME`, `STARSHIP_PALETTE`
- `kitty.conf` — kitty colors
- `cava.ini` — optional, a `[color]` section for cava

Add a `[palettes.<STARSHIP_PALETTE>]` section to `starship.toml` using the same color names as the others (`fg`, `grey`, `red`, `orange`, `yellow`, `green`, `aqua`, `blue`, `purple`), and a Plank theme under `plank/` if you want a matching dock.

## License

MIT for the script and configuration. The kitty color files keep the licenses noted in their headers; see [LICENSE](LICENSE).
