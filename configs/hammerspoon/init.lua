hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function ()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w/2
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function ()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w/2)
    f.y = max.y
    f.w = max.w/2
    f.h = max.h
    win:setFrame(f)
end)

function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
    if doReload then
      hs.reload()
    end
  end
end
hs.pathwatcher.new(os.getenv("HOME") .. ".hammerspoon/", reloadConfig):start()

function applicationWatcher(appName, eventType, appObject)
  if (eventType == hs.application.watcher.activated) then
    if (appName == "Emacs") then
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local max = screen:frame()

      f.x = max.x + ( max.w * 0.66 )
      f.y = max.y
      f.w = max.w * 0.66
      f.h = max.h
      win:setFrame(h)
    end
  end
end
local appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
