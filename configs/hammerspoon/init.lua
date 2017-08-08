
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h / 2
    win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y + max.h/2
    f.w = max.w
    f.h = max.h / 2
    win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    local rotation = screen:rotate()

    if rotation == 0 then
      screen:rotate(90)
    else
      screen:rotate(0)
    end
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
hs.loadSpoon('ControlEscape'):start()
hs.alert.show("Config loaded")
