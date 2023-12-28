-- Supports cycling through _not_ minimized windows from the same app.
local function findWindowByBundleID(bundleID)
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

local function focusWindow(bundleID)
  local window = findWindowByBundleID(bundleID)

  if window then
    window:focus()
  else
    print("Window not found for bundle ID: " .. bundleID)
  end
end

-- Find bundle ID via `mdls -name kMDItemCFBundleIdentifier -r /Applications/iTerm.app`
local hyperAppShortcuts = {
  { "J", "com.googlecode.iterm2" },
  { "K", "com.jetbrains.intellij.ce" },
  { "L", "com.brave.Browser" },
  { "C", "Cisco-Systems.Spark" },
}
local hyper = { "cmd", "alt", "ctrl", "shift" }

hs.hotkey.bind(hyper, "r", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

hs.loadSpoon('EmmyLua')
local VimMode = hs.loadSpoon('VimMode')
local vim = VimMode:new()

local k = hs.hotkey.modal.new('shift', 'space')
function k:entered() hs.alert 'Entered mode' end

function k:exited() hs.alert 'Exited mode' end

k:bind('', 'escape', function() k:exit() end)
k:bind('', 'C', nil, function()
  for _, arr in ipairs(hyperAppShortcuts) do
    if (arr[1] == 'C') then
      focusWindow(arr[2])
    end
  end
end)
k:bind('', 'J', nil, function()
  for _, arr in ipairs(hyperAppShortcuts) do
    if (arr[1] == 'J') then
      focusWindow(arr[2])
    end
  end
end)
k:bind('', 'k', nil, function()
  for _, arr in ipairs(hyperAppShortcuts) do
    if (arr[1] == 'K') then
      focusWindow(arr[2])
    end
  end
end)
k:bind('', 'l', nil, function()
  for _, arr in ipairs(hyperAppShortcuts) do
    if (arr[1] == 'L') then
      focusWindow(arr[2])
    end
  end
end)

-- Take app name from Activity Monitor.
vim:disableForApp('iTerm')
vim:disableForApp('IntelliJ IDEA')
--  :enterWithSequence('jk')

vim:bindHotKeys({ enter = { { 'ctrl' }, ';' } })
vim:shouldDimScreenInNormalMode(false)

hs.grid.setGrid('8x4')
hs.grid.HINTS = {
  { 'Q', 'W', 'E', 'U', 'I', 'O' },
  { 'A', 'S', 'D', 'J', 'K', 'L' },
  { 'Z', 'X', 'C', 'N', 'M', ',' },
}
hs.window.animationDuration = 0
hs.hotkey.bind(hyper, "w", function()
  hs.grid.show()
end)


for _, shortcut in ipairs(hyperAppShortcuts) do
  hs.hotkey.bind(hyper, shortcut[1], function()
    focusWindow(shortcut[2])
  end)
end
