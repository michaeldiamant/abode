local hyper = {"cmd", "alt", "ctrl", "shift"}

hs.hotkey.bind(hyper, "r", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

local VimMode = hs.loadSpoon('VimMode')
local vim = VimMode:new()

-- Take app name from Activity Monitor.
vim:disableForApp('iTerm')
vim:disableForApp('IntelliJ IDEA')
--  :enterWithSequence('jk')

vim:bindHotKeys({ enter = {{'ctrl'}, ';'} })
vim:shouldDimScreenInNormalMode(false)

hs.grid.setGrid('8x4')
hs.grid.HINTS={
  {'Q', 'W', 'E', 'U', 'I', 'O'},
  {'A', 'S', 'D', 'J', 'K', 'L'},
  {'Z', 'X', 'C', 'N', 'M', ','},
}
hs.window.animationDuration = 0
hs.hotkey.bind(hyper, "w", function()
  hs.grid.show()
end)

-- Find bundle ID via `mdls -name kMDItemCFBundleIdentifier -r /Applications/iTerm.app`
hyperAppShortcuts = {
  { "J", "com.googlecode.iterm2" },
  { "K", "com.jetbrains.intellij.ce"},
  { "L", "com.brave.Browser" },
  { "C", "Cisco-Systems.Spark" },
}

-- Supports cycling through _not_ minimized windows from the same app.
-- Here's 
function findWindowByBundleID(bundleID)
    local focusedWin = hs.window.focusedWindow()
    local windows = hs.window.filter.new():getWindows()
    for _, win in ipairs(windows) do
        local app = win:application()
        if app and app:bundleID() == bundleID and not (win:id() == focusedWin:id()) then
            return win
        end
    end
    return nil
end

for _,shortcut in ipairs(hyperAppShortcuts) do
  hs.hotkey.bind(hyper, shortcut[1], function()
    local window = findWindowByBundleID(shortcut[2])

    if window then
      window:focus()
    else
      print("Window not found for bundle ID: " .. shortcut[2])
    end
  end)
end

