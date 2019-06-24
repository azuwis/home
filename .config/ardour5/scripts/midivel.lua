ardour {
  ["type"]    = "dsp",
  name        = "MIDI Velcocity Curve",
  category    = "Utility",
  license     = "MIT",
  author      = "Ardour Lua Task Force",
  description = [[Midi Filter for Velocity Curve.]]
}

function dsp_ioconfig ()
  return { { midi_in = 1, midi_out = 1, audio_in = 0, audio_out = 0}, }
end

function dsp_run (_, _, n_samples)
  local cnt = 1;
  function tx_midi (time, data)
    midiout[cnt] = {}
    midiout[cnt]["time"] = time;
    midiout[cnt]["data"] = data;
    cnt = cnt + 1;
  end

  local mapx = {0, 41, 63, 81, 102, 127}
  local mapy = {0, 38, 61, 86, 117, 127}
  function map_velocity (v)
    local i = v // (127 // (#mapx - 1)) + 1
    while true do
      if i <= 0 then
        return mapy[1]
      end
      if v >= mapx[i] then
        if i >= #mapx then
          return mapy[i]
        end
        if v < mapx[i+1] then
          return mapy[i] + (v - mapx[i]) * (mapy[i+1] - mapy[i]) // (mapx[i+1] - mapx[i])
        else
          i = i + 1
        end
      else
        i = i - 1
      end
    end
  end

  -- for each incoming midi event
  for _,b in pairs (midiin) do
    local t = b["time"] -- t = [ 1 .. n_samples ]
    local d = b["data"] -- get midi-event bytes
    local event_type
    if #d == 0 then event_type = -1 else event_type = d[1] >> 4 end
    if (#d == 3 and event_type == 9) then -- note on
      d[3] = map_velocity (d[3])
      tx_midi (t, d)
    else -- pass thru all other events unmodified
      tx_midi (t, d)
    end
  end
end
