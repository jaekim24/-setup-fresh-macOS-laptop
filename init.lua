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
hs.hotkey.bind(mash, 'm', function() hs.window.focusedWindow():move(units.botRight,    nil, true) end)
hs.hotkey.bind(mash, 'f', function() hs.window.focusedWindow():move(units.maximum,    nil, true) end)

-- keybinds to applications
hs.grid.setMargins({0, 0})
hs.hotkey.bind(mash1 , 'c', function () hs.application.launchOrFocus("Visual Studio Code") end)
hs.hotkey.bind(mash1 , 't', function () hs.application.launchOrFocus("Terminal") end)
hs.hotkey.bind(mash1 , 'b', function () hs.application.launchOrFocus("Brave Browser Beta") end)
hs.hotkey.bind(mash1 , 'f', function () hs.application.launchOrFocus("Finder") end)




-- Function to increase window size
function increaseWindowSize()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    local horizontalIncrease = max.w * 0.1
    local verticalIncrease = max.h * 0.1

    -- Check horizontal position
    if f.x == max.x and f.w <= max.w / 2 then
        -- Left half: Increase width to the right
        f.w = math.min(f.w + horizontalIncrease, max.w)
    elseif f.x >= max.x + (max.w / 2) then
        -- Right half: Increase width to the left
        local newWidth = math.min(f.w + horizontalIncrease, max.w)
        f.x = max.x + max.w - newWidth
        f.w = newWidth
    else
        -- Middle: Increase both sides
        local hIncrease = horizontalIncrease / 2
        f.x = math.max(f.x - hIncrease, max.x)
        f.w = math.min(f.w + hIncrease * 2, max.w)
    end

    -- Check vertical position
    if f.y == max.y and f.h <= max.h / 2 then
        -- Top half: Increase height downwards
        f.h = math.min(f.h + verticalIncrease, max.h)
    elseif f.y >= max.y + (max.h / 2) then
        -- Bottom half: Increase height upwards
        local newHeight = math.min(f.h + verticalIncrease, max.h)
        f.y = max.y + max.h - newHeight
        f.h = newHeight
    else
        -- Middle: Increase both directions
        local vIncrease = verticalIncrease / 2
        f.y = math.max(f.y - vIncrease, max.y)
        f.h = math.min(f.h + vIncrease * 2, max.h)
    end
    
    win:setFrame(f)
end


-- this doesnt work correctly 
-- Function to decrease window size
function decreaseWindowSize()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    local horizontalDecrease = max.w * 0.1
    local verticalDecrease = max.h * 0.1
    local minWidth = max.w * 0.25  -- Minimum width: 25% of screen width
    local minHeight = max.h * 0.25 -- Minimum height: 25% of screen height

    -- Check horizontal position
    if f.x == max.x and f.w <= max.w / 2 then
        -- Left half: Decrease width from the right
        f.w = math.max(f.w - horizontalDecrease, minWidth)
    elseif f.x >= max.x + (max.w / 2) then
        -- Right half: Decrease width from the left
        local newWidth = math.max(f.w - horizontalDecrease, minWidth)
        f.x = max.x + max.w - newWidth
        f.w = newWidth
    else
        -- Middle: Decrease from both sides
        local hDecrease = horizontalDecrease / 2
        f.x = math.min(f.x + hDecrease, max.x + max.w - minWidth)
        f.w = math.max(f.w - hDecrease * 2, minWidth)
    end

    -- Check vertical position
    if f.y == max.y and f.h <= max.h / 2 then
        -- Top half: Decrease height from the bottom
        f.h = math.max(f.h - verticalDecrease, minHeight)
    elseif f.y >= max.y + (max.h / 2) then
        -- Bottom half: Decrease height from the top
        local newHeight = math.max(f.h - verticalDecrease, minHeight)
        f.y = max.y + max.h - newHeight
        f.h = newHeight
    else
        -- Middle: Decrease from both directions
        local vDecrease = verticalDecrease / 2
        f.y = math.min(f.y + vDecrease, max.y + max.h - minHeight)
        f.h = math.max(f.h - vDecrease * 2, minHeight)
    end

    win:setFrame(f)
end


-- Bind the function to a hotkey (Command + Shift + -)
hs.hotkey.bind(mash1, 'j', decreaseWindowSize)
hs.hotkey.bind(mash1, 'k', increaseWindowSize)






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





