-- Foundation remapping
-----------------------------------------------------------------
-- https://github.com/hetima/hammerspoon-foundation_remapping

-- Foundaation Remaps will only do physical key remapping. You can't for example, swap ; and : like I want to with it.
-- keycodes list here: https://developer.apple.com/library/archive/technotes/tn2450/_index.html

capsLock = 0x39
f19 = 0x6E
f20 = 0x6F

kf18 = 0x4F -- karabiner right-command
kf19 = 0x50 -- karabiner fn
kf20 = 0x5A -- karabiner right-option

warp = kf18
-- tilt = kf18

local FRemap = require('foundation_remapping')
local remapper = FRemap.new()

-- remapper:remap(capsLock, capsLock)
-- remapper:remap(capsLock, warp)
-- remapper:remap(rcmd, f20)
-- f12: 0x49
-- f19: 0x6E

-- remapper:register()
---------------------------------------------------------------

local eventtap = hs.eventtap
local eventTypes = hs.eventtap.event.types

local warpEnabled = false
local warpModes = {}
local warpMods = {}


capsPressListener = eventtap.new({eventTypes.keyDown}, function(event)
    if event:getKeyCode() == warp then
        print('warp!')
        warpEnabled = true
        return true
    end
    return false
end):start()

capsReleaseListener = hs.eventtap.new({eventTypes.keyUp}, function(event)
    if event:getKeyCode() == warp then
        print("no warp!")
        warpEnabled = false
        return true
    end
    return false
end):start()

local warpModeKeys = {}
warpModeKeys['s'] = 'select'
warpModeKeys['d'] = 'delete'

local warpModKeys = {}
warpModKeys['a'] = 'tri'

capsModeModDownListener = eventtap.new({eventTypes.keyDown}, function(event)
    if not warpEnabled then
        return false
    end
    local char = event:getCharacters():lower()
    local mode = warpModeKeys[char]
    if mode then
        local modeInUse = false
        for _, v in pairs(warpModes) do
            if v == mode then
                modeInUse = true
                break
            end
        end
        if not modeInUse then
            table.insert(warpModes, mode)
            print("entered " .. mode)
        end
        return true
    end
    local mod = warpModKeys[char]
    if mod then
        if not warpMods[mod] then hs.alert.show(char .. ": adding mod " .. mod) end
        warpMods[mod] = true
        return true
    end
end):start()

capsModeModListener = eventtap.new({eventTypes.keyUp}, function(event)
    if not warpEnabled then
        return false
    end
    local char = event:getCharacters():lower()
    local mode = warpModeKeys[char]
    if mode then
            local idx = 0
        for k,v in pairs(warpModes) do
            if v == mode then
                idx = k
                break
            end
        end
        if idx > 0 then
            table.remove(warpModes, idx)
            hs.alert.show("leaving ".. mode .. " | " .. table.concat(warpModes, ", "))
        end
        return true
    end
    local mod = warpModKeys[char]
    if mod then
        hs.alert.show("removing mod " .. mod)
        warpMods[mod] = false
        return true
    end
end):start()


local function keystroker(mod, key)
    return function (event)
        print(table.concat(mod, "+") .. "+" .. key)
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
        default = keystroker({'cmd'}, 'left'),
        tri = keystroker({'ctrl'}, 'a')
    },
    select = {
        default = keystroker({'cmd', 'shift'}, 'left'),
        tri = keystroker({'ctrl', "shift"}, 'a')
    },
    delete = {
        default = keystrokers({{{'cmd', 'shift'}, 'left'}, {{}, 'delete'}}),
        tri = keystrokers({{{"ctrl", "shift"}, "a"}, {{}, 'delete'}})
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
        default = keystrokers({{{'ctrl'}, 'a'}, {{'shift'}, 'down'}, {{}, 'delete'}})
    }
}

actionKeys['o'] = {
    move = {
        default = keystroker({'cmd'}, 'right')
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
    if not warpEnabled then
        return false
    end
    local action = actionKeys[event:getCharacters(true):lower()]
    if action then
        local mode = warpModes[#warpModes] or 'move'
        if not mode then return true end
        local modList = {}
        for k, v in pairs(warpMods) do
            if v then table.insert(modList, k) end
        end
        local modeAction = action[mode]
        local modLabel = table.concat(modList, ",")
        local f = modeAction[modLabel] or modeAction['default']
        if f then f(event) end
    end
    return true
end):start()