-- Vertical tabs
local vertical_tabs = require("vertical_tabs")

-- Keybindings
local modes = require("modes")
modes.add_binds("normal", {
    -- Tabs
    { "q", "Go to previous tab.", function (w) w:prev_tab() end },
    { "w", "Go to next tab (or `[count]` nth tab).",
      function (w, _, m)
        if not w:goto_tab(m.count) then w:next_tab() end
      end, {count=0} },
})

-- Form filler
local formfiller = require "formfiller"
formfiller.extend({pass = function(s) return io.popen("pass " .. s):read() end})

-- Settings
local settings = require "settings"

settings.webview.zoom_level = 170
settings.window.home_page = "luakit://newtab"
