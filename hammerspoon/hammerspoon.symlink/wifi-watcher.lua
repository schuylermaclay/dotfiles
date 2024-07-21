-- https://dev.to/mcrowder65/configuring-your-mac-to-display-the-wifi-name-on-the-menu-bar-3p8b
-- requires location services to be enabled for HS TODO need a way to prompt https://github.com/Hammerspoon/hammerspoon/issues/3537
wifiMenu = hs.menubar.new()

-- refresh on click
wifiMenu:setClickCallback(function()
  ssidChanged()
end)

function init()
  local wifiName = hs.wifi.currentNetwork()
  print('wifiName: ', wifiName)

  -- if home truncate ssid
  if wifiName == 'wireless5life' or wifiName == 'Bluff_House' then
    wifiName = '~'
  elseif wifiName == nil then
    wifiName = 'no ssid'
  end
  wifiMenu:setTitle(wifiName)
end

init()

function ssidChanged()
  local wifiName = hs.wifi.currentNetwork()
  print('wifiName: ', wifiName)

  if wifiName == 'wireless5life' or wifiName == 'Bluff_House' then
    wifiName = '~'
  end

  if wifiName then
    wifiMenu:setTitle(wifiName)
  else
    wifiMenu:setTitle("Wifi Off")
  end
end

-- TODO add something on click/up down mb/s etc
wifiWatcher = hs.wifi.watcher.new(ssidChanged):start()
