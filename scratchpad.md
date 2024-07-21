# Oneliners, shortcuts, commands etc. to remember

delete contents of a dir:
`rm -rf /path/to/directory/{*,.*}`

sort in place a line range
`echo 'x' | ex -s -c '2,5!sort' file`

docker leftover files fail, also may need to grant terminal file system perms
`brew reinstall --cask docker --zap`
`brew remove --cask docker --zap --force`


`find . -type f -name "\*.otf" -exec fontforge --script ./font-patcher --complete {} \;`

when no man pages:
`strings (which find)`

htmlImport in google sheets sheets

`echo brew \"htop\" | gsed -E 's/(brew "htop")/\1\nnext line/'`

vscode: cmd k quote to select in quote

Alt+Enter  for multiline shell

https://github.com/fish-shell/fish-shell/issues/7374

show fish func def
`type mcd`

https://github.com/mattmc3/fishconf/blob/main/functions/which.fish

literal evil:
https://github.com/hyiltiz/vim-plugins-profile


https://developer.chrome.com/docs/extensions/how-to/distribute/install-extensions#preferences


`asdf global nodejs latest:20`


https://eclecticlight.co/

linen white: f2ebda
https://www.easyrgb.com/en/convert.php#inputFORM

#### readline shortcuts
control + f = forward
control + b = backward
control + n = next line
control + p = previous line
control + h = delete
control + d = forward delete
control + a = move to beginning of line
control + e = move to end of line
control + k = kill to eol forward
control + u = kill to start of line
control + w = kill previous word


## Misc
`/Users/schuylermaclay/Library/Containers/com.if.Amphetamine/Data/Downloads/`

https://forums.developer.apple.com/forums/thread/743081 sometimes you gotta drag delete (or disable SIP)

https://stackoverflow.com/questions/73705091/accept-github-copilot-inline-suggestion-with-right-arrow-key-instead-of-tab-in-v

https://github.com/thoughtworks/talisman

https://github.com/jcelliott/dotfiles/blob/master/.config/fish/functions/abbr_set.fish

https://github.com/koekeishiya/yabai/wiki

https://github.com/davidosomething/dotfiles/blob/dev/chromium/extensions.md

`rip /Users/schuylermaclay/Library/Preferences/ByHost/co.zeit.hyper.ShipIt.36CCF272-16DB-55B0-8B3A-136078CE4434.plist`

https://blog.tovmasyan.io/tech-resume-writing-guide-in-2024-ab894579d7a2

https://kevinmgrimes.com/post/homebrew-macos/

https://medium.com/@chetcorcos/a-simple-launchd-tutorial-9fecfcf2dbb3

https://github.com/trapd00r/LS_COLORS/blob/master/LS_COLORS

https://fotoallerlei.com/blog/2019/managing-your-git-repositories-with-ghq/

https://unix.stackexchange.com/questions/108699/documentation-on-less-termcap-variables

https://stackoverflow.com/questions/28664804/set-awk-output-to-variable-in-fish-shell

add dock script: https://github.com/webpro/dotfiles/blob/main/macos/dock.sh

file explorer: https://github.com/sxyazi/yazi

[amazing video, ostensibly about nvim](https://www.youtube.com/watch?v=fFHlfbKVi30)
