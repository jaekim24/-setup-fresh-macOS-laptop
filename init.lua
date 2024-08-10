
-- window management
hs.window.animationDuration = 0
units = {
  topLeft       = { x = 0.00, y = 0.00, w = 0.50, h = 0.50 },
  topRight      = { x = 0.50, y = 0.00, w = 0.50, h = 0.50 },
  botLeft       = { x = 0.00, y = 0.50, w = 0.50, h = 0.50 },
  botRight      = { x = 0.50, y = 0.50, w = 0.50, h = 0.50 },
  right30       = { x = 0.70, y = 0.00, w = 0.30, h = 1.00 },
  right50       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  right70       = { x = 0.30, y = 0.00, w = 0.70, h = 1.00 },
  left70        = { x = 0.00, y = 0.00, w = 0.70, h = 1.00 },
  left50        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  left30        = { x = 0.00, y = 0.00, w = 0.30, h = 1.00 },
  top50         = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  bot50         = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  upright30     = { x = 0.70, y = 0.00, w = 0.30, h = 0.50 },
  botright30    = { x = 0.70, y = 0.50, w = 0.30, h = 0.50 },
  upleft70      = { x = 0.00, y = 0.00, w = 0.70, h = 0.50 },
  botleft70     = { x = 0.00, y = 0.50, w = 0.70, h = 0.50 },
  maximum       = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 }
}

mash = { 'alt' }

hs.hotkey.bind(mash, 'h', function() hs.window.focusedWindow():move(units.left50,     nil, true) end)
hs.hotkey.bind(mash, 'j', function() hs.window.focusedWindow():move(units.bot50,     nil, true) end)
hs.hotkey.bind(mash, 'k', function() hs.window.focusedWindow():move(units.top50,     nil, true) end)
hs.hotkey.bind(mash, 'l', function() hs.window.focusedWindow():move(units.right50,    nil, true) end)
hs.hotkey.bind(mash, 'u', function() hs.window.focusedWindow():move(units.topLeft,    nil, true) end)
hs.hotkey.bind(mash, 'i', function() hs.window.focusedWindow():move(units.topRight,    nil, true) end)
hs.hotkey.bind(mash, 'n', function() hs.window.focusedWindow():move(units.botLeft,    nil, true) end)
hs.hotkey.bind(mash, ',', function() hs.window.focusedWindow():move(units.botRight,    nil, true) end)
hs.hotkey.bind(mash, 'f', function() hs.window.focusedWindow():move(units.maximum,    nil, true) end)


-- keybinds to applications
hs.grid.setMargins({0, 0})
hs.hotkey.bind(mash, 'c', function () hs.application.launchOrFocus("Visual Studio Code") end)
hs.hotkey.bind('ctrl', 't', function () hs.application.launchOrFocus("Terminal") end)
hs.hotkey.bind('ctrl', 'b', function () hs.application.launchOrFocus("Brave Browser Beta") end)
hs.hotkey.bind('ctrl', 'f', function () hs.application.launchOrFocus("Finder") end)


-- automatically reload configs
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

