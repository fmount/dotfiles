-- Hammerspoon config — i3-like scratchpad for macOS
-- Works alongside Amethyst for tiling

local alt = {"alt"}
local altShift = {"alt", "shift"}

---------------------------------------------------------
-- Scratchpad
--
-- Alt+Shift+minus : send focused window to scratchpad
-- Alt+minus       : show/cycle scratchpad windows
---------------------------------------------------------

local scratchpad = {}

local function sendToScratchpad()
    local win = hs.window.focusedWindow()
    if not win then return end

    local appName = win:application():name()
    table.insert(scratchpad, {
        window = win,
        app = appName,
        frame = win:frame():copy(),
    })

    win:application():hide()
    hs.alert.show("→ scratchpad (" .. #scratchpad .. ")")
end

local function showFromScratchpad()
    if #scratchpad == 0 then
        hs.alert.show("scratchpad empty")
        return
    end

    local entry = table.remove(scratchpad, 1)
    local win = entry.window

    if not win or not win:application() then
        hs.alert.show("window gone, skipping")
        if #scratchpad > 0 then
            showFromScratchpad()
        end
        return
    end

    local app = win:application()
    app:unhide()
    win:unminimize()
    win:raise()
    win:focus()

    local screen = hs.screen.mainScreen():frame()
    local w = screen.w * 0.6
    local h = screen.h * 0.7
    local x = screen.x + (screen.w - w) / 2
    local y = screen.y + (screen.h - h) / 2
    win:setFrame(hs.geometry.rect(x, y, w, h))

    hs.alert.show("← scratchpad (" .. #scratchpad .. " left)")
end

hs.hotkey.bind(altShift, "-", sendToScratchpad)
hs.hotkey.bind(alt, "-", showFromScratchpad)

---------------------------------------------------------
-- Quick reload
-- Alt+Shift+c : reload config (like i3 Alt+Shift+c)
---------------------------------------------------------

hs.hotkey.bind(altShift, "c", function()
    hs.reload()
end)
hs.alert.show("hammerspoon loaded")
