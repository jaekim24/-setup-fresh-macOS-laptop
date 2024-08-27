----------------------------------
-- automatically reload configs --
----------------------------------
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



----------------------------------
------- window management---------
----------------------------------
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
mash1 = {'alt' , 'shift'}

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




----------------------------------
---- last window quit program ----
----------------------------------

-- Initialize the watcher and menubar
local windowWatcher = nil
local menubar = nil
local isEnabled = true


-- List of apps to exclude from auto-quitting
local excludedApps = {
    "Hammerspoon",
    "Spotlight",
    "Finder"  
    }

-- Function to check if an app should be excluded
local function isExcluded(appName)
    for _, excludedApp in ipairs(excludedApps) do
        if appName == excludedApp then
            return true
        end
    end
    return false
end

-- Function to check and quit the application if the last window is closed
local function checkAndQuitApp(window)
    if not isEnabled then return end 
    local app = window:application()
    if not app then return end

    local appName = app:name()

    -- Don't quit excluded apps
    if isExcluded(appName) then return end

    -- Check if the application has any windows left
    local allWindows = app:allWindows()

    -- If there are no windows left, quit the app
    if #allWindows == 0 then
        -- Delay the quit operation slightly to ensure the window closes first
        hs.timer.doAfter(0.1, function()
            app:kill()
        end)
    end
end

-- Function to start the watcher
local function startWatcher()
    if windowWatcher then
        windowWatcher:stop()
    end

    windowWatcher = hs.window.filter.new(true)
    windowWatcher:subscribe(hs.window.filter.windowDestroyed, checkAndQuitApp)
end


-- Function to stop the watcher
local function stopWatcher()
    if windowWatcher then
        windowWatcher = nil
    end
end


-- Function to create menu
local function createMenu()
    local menuItems = {
        {title = "Last Window Quit Enabled", checked = true, fn = function() end},
        {title = "-"}, -- Separator
        {title = "About Last Window Quit", fn = function()
            hs.alert.show("Last Window Quit: Quits apps when closing the last window (except excluded apps)")
        end},
        {title = "-"}, -- Separator
        {title = "Quit Menu", fn = function()
            if menubar then
                menubar:delete()
                menubar = nil
            end
        end}
    }

    if not menubar then
        menubar = hs.menubar.new()
    end
    menubar:setTitle("LWQ")  -- LWQ for "Last Window Quit"
    menubar:setMenu(menuItems)
end

-- Function to toggle the menubar
local function toggleMenubar()
    if menubar then
        menubar:delete()
        menubar = nil
	stopWatcher()
	isEnabled = false
        hs.alert.show("Last Window Quit menubar removed")
    else
        createMenu()
	startWatcher()    
	isEnabled = true
        hs.alert.show("Last Window Quit menubar restored")
    end
end

-- Start the watcher when the script loads
startWatcher()

-- Create the menu initially
createMenu()

-- Bind hotkey to toggle menubar
hs.hotkey.bind({"alt", "shift"}, "Q", toggleMenubar)

-- Log that the script has loaded
print("Last Window Quit script loaded")





