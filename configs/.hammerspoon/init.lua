-- Foundation remapping
-----------------------------------------------------------------
-- https://github.com/hetima/hammerspoon-foundation_remapping

-- Foundaation Remaps will only do physical key remapping. You can't for example, swap ; and : like I want to with it.
-- keycodes list here: https://developer.apple.com/library/archive/technotes/tn2450/_index.html

capsLock = 0x39
caps = 0x6E -- F19


local FRemap = require('foundation_remapping')
local remapper = FRemap.new()

-- remapper:remap(capsLock, capsLock)
remapper:remap(capsLock, caps)

-- f12: 0x49
-- f19: 0x6E

-- remapper:register()
---------------------------------------------------------------

local eventtap = hs.eventtap
local eventTypes = hs.eventtap.event.types

local capsEnabled = false
local capsModes = {}
local capsMods = {}

capsPressListener = eventtap.new({eventTypes.keyDown}, function(event)
    if event:getKeyCode() == caps then
        capsEnabled = true
        return true
    end
    return false
end) -- :start()

capsReleaseListener = hs.eventtap.new({eventTypes.keyUp}, function(event)
    if event:getKeyCode() == caps then
        capsEnabled = false
        return true
    end
    return false
end) -- :start()

local capsModeKeys = {}
capsModeKeys['s'] = 'select'
capsModeKeys['d'] = 'delete'

local capsModKeys = {}
capsModKeys['a'] = 'tri'

capsModeModListener = eventtap.new({eventTypes.keyDown, eventTypes.keyUp}, function(event) 
    if not capsEnabled then
        return false
    end
    local char = event:getCharacters():lower()
    local mode = capsModeKeys[char]
    if mode then
        if (event:getType() == eventTypes.keyDown) then
            local modeInUse = false
            for _, v in pairs(capsModes) do
                if v == mode then
                    modeInUse = true
                    break
                end
            end
            if not modeInUse then
                table.insert(capsModes, mode)
                hs.alert.show("entered " .. mode .. " | " .. table.concat(capsModes, ", "))
            end
        else
            local idx = 0
            for k,v in pairs(capsModes) do
                if v == mode then
                    idx = k
                    break
                end
            end
            if idx > 0 then
                table.remove(capsModes, idx)
                hs.alert.show("leaving ".. mode .. " | " .. table.concat(capsModes, ", "))
            end
        end
        return true
    end
    local mod = capsModKeys[char]
    if mod then
        if (event:getType() == eventTypes.keyDown) then
            if not capsMods[mod] then hs.alert.show(char .. ": adding mod " .. mod) end
            capsMods[mod] = true
        else
            hs.alert.show("removing mod " .. mod)
            capsMods[mod] = false
        end
        return true
    end
end) -- :start()


local function keystroker(mod, key)
    return function (event)
        hs.eventtap.keyStroke(mod, key, 0)
    end
end

local function keystrokers(keys)
    return function(event)
        for i, k in pairs(keys) do
            hs.alert.show(table.concat(k[1], "+") .. "+" .. k[2])
            hs.eventtap.keyStroke(k[1], k[2], 0)
        end
    end
end

local actionKeys = {}

actionKeys['u'] = {
    move = {
        default = keystroker({'cmd'}, 'left')
    },
    select = {
        default = keystroker({'cmd', 'shift'}, 'left')
    },
    delete = {
        default = keystrokers({{{'cmd', 'shift'}, 'left'}, {{}, 'delete'}})
    }
}

actionKeys['i'] = {
    move = {
        default = keystroker({}, 'up'),
    },
    select = {
        default = keystroker({'shift'}, 'up')
    },
    delete = {
        default = keystrokers({{{'cmd'}, 'right'}, {{'cmd', 'shift'}, 'left'}, {{}, 'delete'}, {{}, 'delete'}})
    }
}

actionKeys['o'] = {
    move = {
        default = keystroker({'cmd'}, 'left')
    },
    select = {
        default = keystroker({'cmd', 'shift'}, 'right')
    },
    delete = {
        default = keystrokers({{{'cmd', 'shift'}, 'right'}, {{}, 'delete'}})
    }
}

actionKeys['j'] = {
    delete = {
        tri = keystroker({}, 'delete'),
        default = keystroker({'alt'}, 'delete')
    },
    select = {
        tri = keystroker({'shift'}, 'left'),
        default = keystroker({'alt', 'shift'}, 'left')
    },
    move = {
        tri = keystroker({}, 'left'),
        default = keystroker({'alt'}, 'left')
    }
}

actionKeys['k'] = {
    move = {
        default = keystroker({}, 'down'),
    },
    select = {
        default = keystroker({'shift'}, 'down'),
    },
}

actionKeys['l'] = {
    delete = {
        tri = keystroker({}, 'forwarddelete'),
        default = keystroker({'alt'}, 'forwarddelete')
    },
    select = {
        tri = keystroker({'shift'}, 'right'),
        default = keystroker({'alt', 'shift'}, 'right')
    },
    move = {
        tri = keystroker({}, 'right'),
        default = keystroker({'alt'}, 'right')
    }
}

capsModePressListener = eventtap.new({eventTypes.keyDown}, function(event)
    if not capsEnabled then
        return false
    end
    local action = actionKeys[event:getCharacters(true):lower()]
    if action then
        local mode = capsModes[#capsModes] or 'move'
        if not mode then return true end
        local modList = {}
        for k, v in pairs(capsMods) do
            if v then table.insert(modList, k) end
        end
        local modeAction = action[mode]
        local modLabel = table.concat(modList, ",")
        local f = modeAction[modLabel] or modeAction['default']
        if f then f(event) end
        return true
    end
end) -- :start()


local hyperex = require('hyperex')

local lShift = hyperex.new('shift')
lShift:setEmptyHitKey('9', {'shift'})

local rShift = hyperex.new('rightshift')
rShift:setEmptyHitKey('0', {'shift'})

-- F19 => hyper?
-- F19 arrows


-- require('keyboard')

-- hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Left", function ()
--     local win = hs.window.focusedWindow()
--     local f = win:frame()
--     local screen = win:screen()
--     local max = screen:frame()

--     f.x = max.x
--     f.y = max.y
--     f.w = max.w / 2
--     f.h = max.h
--     win:setFrame(f)
-- end)

-- hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "J", function ()
--     local win = hs.window.focusedWindow()
--     local f = win:frame()
--     local screen = win:screen()
--     local max = screen:frame()

--     f.x = max.x
--     f.y = max.y
--     f.w = max.w / 5 * 3
--     f.h = max.h
--     win:setFrame(f)
-- end)


-- hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "Right", function ()
--     local win = hs.window.focusedWindow()
--     local f = win:frame()
--     local screen = win:screen()
--     local max = screen:frame()

--     f.x = max.x + max.w/2
--     f.y = max.y
--     f.w = max.w / 2
--     f.h = max.h
--     win:setFrame(f)
-- end)

-- function rightThird(f, max)
--   f.x = max.x + (max.w/5 * 3)
--   f.w = max.w / 5 * 2
-- end

-- hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "L", function ()
--     local win = hs.window.focusedWindow()
--     local f = win:frame()
--     local screen = win:screen()
--     local max = screen:frame()

--     rightThird(f, max)
--     f.y = max.y
--     f.h = max.h
--     win:setFrame(f)
-- end)

-- -- right top
-- hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "O", function ()
--     local win = hs.window.focusedWindow()
--     local f = win:frame()
--     local screen = win:screen()
--     local max = screen:frame()

--     rightThird(f, max)
--     f.y = max.y
--     f.h = max.h / 2
--     win:setFrame(f)
-- end)


-- -- right bottom
-- hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "K", function ()
--     local win = hs.window.focusedWindow()
--     local f = win:frame()
--     local screen = win:screen()
--     local max = screen:frame()

--     rightThird(f, max)
--     f.y = max.y + (max.h / 2)
--     f.h = max.h / 2
--     win:setFrame(f)
-- end)

function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    remapper:unregister()
    hs.reload()
  end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
