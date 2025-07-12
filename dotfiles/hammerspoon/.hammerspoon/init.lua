-- Map Ctrl + ; to Enter
hs.hotkey.bind({"ctrl"}, ";", function()
    hs.eventtap.keyStroke({}, "return")
end)
-- Map Ctrl + m to Enter
hs.hotkey.bind({"ctrl"}, "m", function()
    hs.eventtap.keyStroke({}, "return")
end)
