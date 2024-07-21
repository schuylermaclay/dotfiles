# Dotfiles
my dots. mostly macos. work in progress, always.

## Karabiner
Used to map the most important keybinding: `caps` to `esc` when tapped, `ctrl` when held. Capslock can be enabled by pressing both shifts simultaneously.

## Prompt (Starship)
Two lines, left and right prompt lots of bells and whistles, pretty snappy. Left prompt is CWD and git info, right prompt has language envs and versions; cloud services; time; battery; last command duration and exit code and other doodads. Bugs: vscode terminal can add an extra newline after prompt (→), there is a weird one with GCP/Shell depth and the fill which is used for spacing the right prompt (can't use the right_prompt starship fn for multiline prompts).

## Color
fish theme is Base16 Eighties
color: fish ignores terminal colors

## Brew/Packages
Still working out best way to sync. Important to remember that mas can't install (purchase) for first time per account, so new apps still need to be added through app store. After that it will keep them synced across machines and up to date.

## Keybinds, Shortcuts
from HS:
-- `cmd + alt + v -> simulate typing paste`

from Alfred:
-- `cmd + shift + v -> plaintext paste` (I actually have no clue where this is set)

`ctrl + f` in fish rebound to forward one bigword, or accept one bigword of suggestion
`alt + w` in fish, whatis/type current token

`ctrl + e` is mapped to End in hammerspoon
End is mapped to accept full line of suggestion in vscode

### vscode bindings
- `alt+x` saves, focuses terminal and runs last command then returns focus to editor
- `cmd 0` for last tab, 1-9 for index
- `command + left-arrow` collapse explore
- chord: `cmd + k, cmd +e`: view extensions
- chord: `⌘ + k, ⌘ + u`: search and insert unicode
- chord: `⌘ + k, ⌘ + s`: edit keybindings in UI
- chord: `⌘ + k, ⌘ + ,`: edit settings.json
- Are they really called chords? Isn't a chord when you press multiple things at the same time? Not a prefix mode... [guess they are called chords...](https://code.visualstudio.com/docs/getstarted/keybindings)


```
{
  "key": "cmd+k c",
  "command": "workbench.files.action.compareWithClipboard"
},{
  "key": "shift+cmd+c",
  "command": "workbench.action.terminal.openNativeConsole",
  "when": "!terminalFocus"
},{
  "key": "ctrl+alt+r",
  "command": "workbench.action.terminal.runRecentCommand",
  "when": "terminalFocus && terminalHasBeenCreated && !accessibilityModeEnabled || terminalFocus && terminalProcessSupported && !accessibilityModeEnabled"
},{
    "key":     "cmd+shift+c",
    "command": "workbench.action.terminal.focus"
},{
    "key":     "cmd+shift+c",
    "command": "workbench.action.focusActiveEditorGroup",
    "when":    "terminalFocus"
}
```

### 1pass:
`cmd '` for autofill
`cmd shift '` for command bar
`cmd ctrl shift '` for command bar

### macOs
`cmd ctrl space` pulls up **emojipicker**
`cmd shift .` show hidden files in finder/file chooser

### Tabs:
`cmd shift a` in chrome brings up tab search
`cmd p` brings up recent tab list in vscode

### alfred
`cmd  c` double tap clipboard vacuum
`cmd shift v` paste as plain text

---

## Installing
Still kind of a mess, one day there may be a Makefile or single script that does everythingvor maybe stow, maybe chezmoi... yadm was not for me. Most stuff is symlinked with the `link.sh` script. There is a Brewfile but the running of it is not automated yet. `brew bundle install` should work. Alfred needs a license .
1. Installing Xcode Command Line Tools
    - `sudo softwardupdate -i -a && xcode-select --install` This will install `git` and `make` if not already installed.
2. Generate a new SSH key and add to GitHub
    - [Generate a new ssh keys][GENSSHKEY]
    - `eval "$(ssh-agent -s)" && ssh-add --apple-use-keychain ~/.ssh/id_ed25519`
3. 1Password shortcuts
    - no way to automate (that I've found), I change them to:
      - `cmd + '` Autofill
      - `cmd + shift + '` Quick Access
      - `cmd + shift + ctrl + '` Main Window
      -  disable lock shortcut (and set sane autolock timeout)

`git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.4.0`


### Sources
I try to link to sources when I can, but I'm sure some stuff slips through the cracks, apologies in advance.


## Todo
-   [ ] iTerm2 settings, dynamic $HOME dir doesn't work -- better way? just switch to Alacritty? Wezterm? Kitty? Warp?
-   [ ] try https://github.com/jdx/mise
-   [ ] get operator mono working
-   [ ] gnutils plugin for fish path
-   [ ] find better use for three finger down left right, opt tab
-   [ ] figure out why fish git msgs are not turning bold yellow anymore
-   [ ] transfer fish funcs to abbr.fish
-   [ ] Atuin? hishtory? stick with fzf?
-   [ ] OV for pager?
-   [ ] brewfile backup https://kevinmgrimes.com/post/homebrew-macos/
-   [ ] do more with karabiner (and less with HS?)
-   [ ] automate or document Hosts-BL
-   [ ] us fn key for more things
-   [ ] raycast instead of Alfred?
-   [ ] mac plist to start iterm (and others) on startup
-   [ ] make vscode extension: status bar line count and size
-   [ ] strip query params from ghqd
-   [ ] sync ghq repos
-   [ ] ghqf?
-   [ ] eza truncated tree mode
-   [ ] excel/numbers that loads in under a minute (libreOffice is actually pretty good)
-   [ ] br.fish symlink and absolute path madness
-   [ ] `~/Dropbox/` what is this dir?
-   [ ] use pinky for `delete`, `-` and `=`

