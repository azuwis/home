function on_vo_change(name, value)
    hwdec = mp.get_property("hwdec")
    if hwdec == "auto" then
        if value == "vdpau" then
            hwdec = "vdpau"
        elseif value == "vaapi" then
            hwdec = "vaapi"
        end
        if hwdec ~= "auto" then
            mp.set_property("hwdec", hwdec)
            mp.msg.info("set hwdec to " .. hwdec)
            hwdec = mp.get_property("hwdec")
            mp.msg.info("current hwdec is " .. hwdec)
        end
    end
end
mp.observe_property("current-vo", "string", on_vo_change)
