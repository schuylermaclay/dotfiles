--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Menubar netspeed meter
--
-- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpeedMenu.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpeedMenu.spoon.zip)
---@class spoon.SpeedMenu
local M = {}
spoon.SpeedMenu = M

-- Redetect the active interface, darkmode …And redraw everything.
-- 
function M:rescan() end

