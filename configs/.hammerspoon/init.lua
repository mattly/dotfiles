
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Left", function ()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "J", function ()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 5 * 3
    f.h = max.h
    win:setFrame(f)
end)


hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Right", function ()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + max.w/2
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

function rightThird(f, max)
  f.x = max.x + (max.w/5 * 3)
  f.w = max.w / 5 * 2
end

hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "L", function ()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    rightThird(f, max)
    f.y = max.y
    f.h = max.h
    win:setFrame(f)
end)

-- right top
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "O", function ()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    rightThird(f, max)
    f.y = max.y
    f.h = max.h / 2
    win:setFrame(f)
end)


-- right bottom
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "K", function ()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    rightThird(f, max)
    f.y = max.y + (max.h / 2)
    f.h = max.h / 2
    win:setFrame(f)
end)

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
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
