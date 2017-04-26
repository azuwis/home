function auto_fullscreen()
  local width = mp.get_property_number("width", 0)
  if width >= 1280 then
    mp.msg.info("set fullscreen for width " .. width)
    mp.set_property("fullscreen", "yes")
  end
end
mp.register_event("file-loaded", auto_fullscreen)
