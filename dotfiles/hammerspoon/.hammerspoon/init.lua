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

local function rgba(r, g, b, a)
  a = a or 1.0

  return {
    red = r / 255,
    green = g / 255,
    blue = b / 255,
    alpha = a
  }
end

-- Define your layers here, as well as the foreground/background of the
-- layer indicator.
--
-- see http://colorsafe.co for some color combos
local layers = {
  default = {
    name = "qwerty",
    background = rgba(187, 187, 187),
    foreground = rgba(46, 52, 59),
  },
  raise = {
    name = "raise",
    background = rgba(163, 209, 255),
    foreground = rgba(15, 72, 128),
  }
}

-- load ~/.hammerspoon/layer-indicator.lua
local LayerIndicator = require("layer-indicator")

-- create a layer indicator
local indicator = LayerIndicator:new(layers.default)


hs.hotkey.bind(hyper, "r", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

-- hs.loadSpoon('EmmyLua')
local VimMode = hs.loadSpoon('VimMode')
local vim = VimMode:new()

local k = hs.hotkey.modal.new('ctrl', 's')
local brightnessShift = 10
function k:entered()
  indicator:setLayer(layers.raise)
  print("brightness = " .. hs.brightness.get())
  hs.brightness.set(hs.brightness.get() - brightnessShift)
  print("brightness after = " .. hs.brightness.get())
  -- hs.alert 'Entered mode'
end

function k:exited()
  indicator:setLayer(layers.default)
  hs.brightness.set(hs.brightness.get() + brightnessShift)
  -- hs.alert 'Exited mode'
end

k:bind('', 'escape', function() k:exit() end)
k:bind('', 'w', function()
  hs.grid.show()
end)
local registerWindowSwitch = function(key)
  local switchWindow = function()
    for _, arr in ipairs(hyperAppShortcuts) do
      if (arr[1] == string.upper(key)) then
        focusWindow(arr[2])
      end
    end
  end
  k:bind('', key, nil, function()
    switchWindow()
    hs.eventtap.keyStroke({}, 'escape')
  end)
  k:bind('shift', key, nil, switchWindow)
end
registerWindowSwitch('c')
registerWindowSwitch('j')
registerWindowSwitch('k')
registerWindowSwitch('l')

local registerBrowserTabSwitch = function(bindKey, alfredKey)
  local switchBrowserTab = function(sendEscape)
    hs.eventtap.keyStroke(hyper, alfredKey, 0)
    hs.timer.doAfter(0.25, function()
      hs.eventtap.keyStroke({}, 'return')
      if sendEscape then
        hs.eventtap.keyStroke({}, 'escape')
      end
    end)
  end
 k:bind('', bindKey, nil, function()
    switchBrowserTab(true)
  end)
  k:bind('shift', bindKey, nil, function()
    switchBrowserTab(false)
  end)
end
registerBrowserTabSwitch('m', '1')
registerBrowserTabSwitch('n', '2')
registerBrowserTabSwitch('s', '3')

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

------------------------------------

-- Thanks to https://github.com/jasonrudolph/keyboard/blob/main/hammerspoon/control-escape.lua
--- === ControlEscape ===
---
--- Make the `control` key more useful: If the `control` key is tapped, treat it
--- as the `escape` key. If the `control` key is held down and used in
--- combination with another key, then provide the normal `control` key
--- behavior.

-- Credit for this implementation goes to @arbelt and @jasoncodes 🙇⚡️😻
--
--   https://gist.github.com/arbelt/b91e1f38a0880afb316dd5b5732759f1
--   https://github.com/jasoncodes/dotfiles/blob/ac9f3ac/hammerspoon/control_escape.lua

local sendEscape = false
local lastMods = {}

local ctrlKeyHandler = function()
  sendEscape = false
end

local ctrlKeyTimer = hs.timer.delayed.new(0.1, ctrlKeyHandler)

local ctrlHandler = function(evt)
  local newMods = evt:getFlags()
  if lastMods["shift"] == newMods["shift"] then
    return false
  end
  if not lastMods["shift"] then
    lastMods = newMods
    sendEscape = true
    ctrlKeyTimer:start()
  else
    if sendEscape then
      hs.eventtap.keyStroke("ctrl", "s", 0)
    end
    lastMods = newMods
    ctrlKeyTimer:stop()
  end
  return false
end

ctrlTap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, ctrlHandler)
ctrlTap:start()

otherHandler = function(evt)
  sendEscape = false
  return false
end

OtherTap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, otherHandler)
OtherTap:start()
