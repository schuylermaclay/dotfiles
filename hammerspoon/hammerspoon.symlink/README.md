# hammerspoon-config
This configuration uses Tmux style hotkey binding, i.e., using a prefix to activate hotkeys.

The prefix is `ctrl+space`, e.g., `prefix - a` = press and release `ctrl+space` first, then press `a`.

much of this is based on: https://github.com/raulchen/dotfiles

rando shorcuts:
- `cmd + alt + v`: paste, simulate typing 
- `cmd + shift + ,`: open macOs System Settings
- `ctrl + e`: End
- `ctrl + w`: Backwards Delete a word
- `prefix + ctrl-h`: window left one third
- `prefix + ctrl-j`: window left two thirds
- `prefix + ctrl-k`: window right two thirds
- `prefix + ctrl-l`: window right one third
- `prefix + ctrl-f`: window full
- `prefix + ctrl-a`: window right one third
- `prefix + ctrl-d`: window left two third

# Window management

-   `prefix - g`: show a 6x6 grid that lets you set the window frame.
-   ~~`option [ + shift ] + tab`: switch windows.~~

Resize and move windows:

-   `prefix - hjkl`: move window to left/bottom/up/right half of screen.
-   `prefix - hj/hk/jl/kl`: move window to the four corners of screen.
-   `prefix - jk`: move window to the center of screen.
-   `prefix - hl`: fullscreen window.
-   `prefix - ctrl+h`: move window to left one-third of screen.
-   `prefix - ctrl+j`: move window to left two-thirds of screen.
-   `prefix - ctrl+k`: move window to right two-thirds of screen.
-   `prefix - ctrl+l`: move window to right one-third of screen.
-   `prefix - shift+hjkl`: move window (need to press esc to normal mode after moving).
-   `prefix - ;`: move window to the next screen.
-   `prefix - -`: shrink window frame.
-   `prefix - =`: expand window frame.


# Double CMD+Q to quit app

This works in all apps, in order to prevent accidentally quitting an app when pressing `cmd+q`.

# Option based key bindings

In macOS, the option key is used to input special characters. However, most people don't ususally need it. So I'm using option key for something more useful.

-   `option + hjkl`: arrow keys.
-   `option + shift + hjkl`: option + arrow keys (move faster).
-   `option + shift + ctrl + hjkl`: shift + arrow keys (selection).
-   `option + y`: home.
-   `option + u`: end.
-   `option + i`: page_up.
-   `option + o`: page_down.
<!-- -   `option + d`: delete. -->
<!-- -   `option + f`: forward delete. -->
-   `control + w`: option + delete.
<!-- -   `option + shift + f`: option + forward delete. -->
<!-- -   `option + n/m`: cmd [+ shift] + tab (switch tabs). -->
-   `option + q`: esc.
<!-- -   `option + p`: play. -->
<!-- -   `option + [`: previous track. -->
<!-- -   `option + ]`: next track. -->
<!-- -   `option + ,`: volume down. -->
<!-- -   `option + .`: volume up. -->
<!-- -   `option + /`: mute. -->


# Other features
-   `prefix - r`: reload Hammerspoon config.
-   `prefix - c`: toggle Hammerspoon console for debug.
-   `prefix - w`: vim style window selector
