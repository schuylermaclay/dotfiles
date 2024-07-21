#!/usr/bin/env bash

# https://en.wikipedia.org/wiki/Smoke_testing_(software)#Etymology
# Adapted from https://gist.github.com/elijahmanor/c10e5787bf9ac6b8c276e47e6745826c

smoke_tests="Normal
\033[1mBold\033[22m
\033[3mItalic\033[23m
\033[3;1mBold Italic\033[0m
\033[4mUnderline\033[24m
== === !== >= <= =>
Nerdfont
         󰾆      󰢻   󱑥   󰒲   󰗼   
Fontawesome Free
                           

"

printf "%b" "${smoke_tests}"
unset smoke_tests

# https://github.com/ahmedelgabri/dotfiles/blob/4057a0cb1330d4105590cbf7ed67226d80b49c75/bin/colortest

DOTS='•••'
printf "\n                 40m     41m     42m     43m     44m     45m     46m     47m\n"
for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
    '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
    '  36m' '1;36m' '  37m' '1;37m'; do
    FG=${FGs// /}
    printf " $FGs \033[$FG  $DOTS  "
    for BG in 40m 41m 42m 43m 44m 45m 46m 47m; do
        printf "$EINS \033[$FG\033[$BG  $DOTS  \033[0m"
    done
    printf "\n"
done
printf "\n"
unset -v DOTS

if command -v fish &>/dev/null; then
    echo "Fish is installed, outputting its colors:"
    fish -c 'set_color -c'
else
    echo "Fish shell is not in the PATH."
fi
