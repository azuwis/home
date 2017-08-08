-- Vertical tabs
local vertical_tabs = require("vertical_tabs")

-- Keybindings
local globals = require("globals")
local modes = require("modes")
modes.add_binds("normal", {
    -- Tabs
    { "q", "Go to previous tab.", function (w) w:prev_tab() end },
    { "w", "Go to next tab (or `[count]` nth tab).",
      function (w, _, m)
        if not w:goto_tab(m.count) then w:next_tab() end
      end, {count=0} },

    -- Zoom
    { "=", "Reset zoom level.", function (w, _) w:zoom_set(globals.default_zoom_level) end },
    { "zz", [[Set current page zoom to `[count]` percent with `[count]zz`, use `[count]zZ` to set full zoom percent.]],
      function (w, _, m) w:zoom_set(m.count/100*globals.default_zoom_level) end, {count=100} },
})
