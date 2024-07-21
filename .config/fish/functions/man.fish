function man --wraps man --description 'Uses batman as for man'

    set -lx BAT_THEME 'Monokai Extended'

    command batman $argv
end
