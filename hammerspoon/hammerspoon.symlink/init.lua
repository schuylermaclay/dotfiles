-- fresh console
hs.console.clearConsole()
hs.window.animationDuration = 0
inspect = hs.inspect.inspect
require('hs.ipc')

hs.loadSpoon('ReloadConfiguration'):start()
hs.loadSpoon('EmmyLua')


-- hickity hack for macos permissions: https://github.com/Hammerspoon/hammerspoon/issues/3537 (doesn't work, just open in system preferences)
print('hs think you are here: ', hs.location.get())

-- ------------------
-- my modules
-- ------------------
prefix = require("prefix")
require("qq_to_quit")
require("keymaps")
require("window")
require("wifi-watcher")
require("surface-finder")


caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
    if state then
        caffeine:setTitle("😈")
    else
        caffeine:setTitle("😴")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

-- ------------------
-- Spoons
-- ------------------

-- speedmenu = hs.loadSpoon("SpeedMenu")
-- speedmenu:start()


prefix.bind('', 'g', function() hs.grid.show() end)
prefix.bind('', 'r', function() hs.reload() end)
prefix.bind('', 'c', function() hs.toggleConsole() end)
-- prefix.bind('', 'q', function() newchromeAnd('IncogDevFullChrome') end)
prefix.bind('', 'space', function() hs.application.launchOrFocus("Alfred 5") end)
prefix.bind('', 'f', function() hs.application.launchOrFocus("Finder") end)
-- prefix.bind('shift', 'c', function() hs.loadSpoon.('Caffeine'):start() end)

hs.loadSpoon('FadeLogo'):start()
