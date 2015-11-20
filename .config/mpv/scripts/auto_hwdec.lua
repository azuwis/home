function auto_hwdec(name, current_vo)
    local current_hwdec = mp.get_property("hwdec")
    local wanted_hwdec = nil
    if current_hwdec == "auto" then
        if current_vo == "vdpau" then
            wanted_hwdec = "vdpau"
        elseif current_vo == "vaapi" then
            wanted_hwdec = "vaapi"
        end
        if wanted_hwdec ~= nil then
            mp.set_property("hwdec", wanted_hwdec)
            mp.msg.info("set hwdec to " .. wanted_hwdec)
            current_hwdec = mp.get_property("hwdec")
            mp.msg.info("current hwdec is " .. current_hwdec)
        end
    end
end
mp.observe_property("current-vo", "string", auto_hwdec)
