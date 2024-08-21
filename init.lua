
-- window management
hs.window.animationDuration = 0
units = {
  topLeft       = { x = 0.00, y = 0.00, w = 0.50, h = 0.50 },
  topRight      = { x = 0.50, y = 0.00, w = 0.50, h = 0.50 },
  botLeft       = { x = 0.00, y = 0.50, w = 0.50, h = 0.50 },
  botRight      = { x = 0.50, y = 0.50, w = 0.50, h = 0.50 },
  right50       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  left50        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  top50         = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  bot50         = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  maximum       = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 }
}

--mash = { 'cmd', 'shift', 'alt' }
mash = {'alt'}
mash1 = {'cmd' , 'shift'}

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
hs.hotkey.bind(mash1 , 'c', function () hs.application.launchOrFocus("Visual Studio Code") end)
hs.hotkey.bind(mash1 , 't', function () hs.application.launchOrFocus("Terminal") end)
hs.hotkey.bind(mash1 , 'b', function () hs.application.launchOrFocus("Brave Browser Beta") end)
hs.hotkey.bind(mash1 , 'f', function () hs.application.launchOrFocus("Finder") end)


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

