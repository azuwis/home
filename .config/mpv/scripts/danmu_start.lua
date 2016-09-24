local utils = require 'mp.utils'

function ev_file_loaded()
  local path = mp.get_property('path')
  if path == nil then
    return
  end
  local pat_vod = {
    '^https?://www%.douyu%.com/(.+)$',
    '^https?://www%.panda%.tv/(.+)$'
  }
  for k,v in pairs(pat_vod) do
    streamer = string.match(path, v)
    if streamer ~= nil then
      local danmu = mp.find_config_file('scripts/danmu')
      if danmu ~= nil then
        utils.subprocess({args={danmu}})
      end
      break
    end
  end
end
mp.register_event('file-loaded', ev_file_loaded)
