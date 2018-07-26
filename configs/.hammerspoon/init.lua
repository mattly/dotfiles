

local hyper = {'cmd', 'alt', 'ctrl', 'shift'}

local function setFrame(xform)
    return function ()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen= win:screen()
        local max = screen:frame()
        xform(f, max)
        win:setFrame(f)
    end
end

hs.hotkey.bind(hyper, "Left", setFrame(function (f, max)
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
end))

hs.hotkey.bind(hyper, "J", setFrame(function (f, max)
    f.x = max.x
    f.y = max.y
    f.w = max.w / 3 * 2
    -- f.w = max.w / 5 * 3
    f.h = max.h
end))


hs.hotkey.bind(hyper, "Right", setFrame(function (f, max)
    f.x = max.x + max.w/2
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
end))

function rightThird(f, max)
  f.x = max.x + (max.w / 3 * 2)
  f.w = max.w / 3
  -- f.x = max.x + (max.w/5 * 3)
  -- f.w = max.w / 5 * 2
end

hs.hotkey.bind(hyper, "L", setFrame(function (f, max)
    rightThird(f, max)
    f.y = max.y
    f.h = max.h
end))

-- right top
hs.hotkey.bind(hyper, "O", setFrame(function (f, max)
    rightThird(f, max)
    f.y = max.y
    f.h = max.h / 2
end))


-- right bottom
hs.hotkey.bind(hyper, "K", setFrame(function (f, max)
    rightThird(f, max)
    f.y = max.y + (max.h / 2)
    f.h = max.h / 2
end))

function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    -- remapper:unregister()
    hs.reload()
  end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
