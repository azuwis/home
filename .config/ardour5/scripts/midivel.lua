ardour {
  ["type"]    = "dsp",
  name        = "MIDI Velcocity Curve",
  category    = "Dynamics",
  license     = "MIT",
  author      = "Ardour Lua Task Force",
  description = [[Midi Filter for Velocity Curve.]]
}

function dsp_ioconfig ()
  return { { midi_in = 1, midi_out = 1, audio_in = 0, audio_out = 0}, }
end

function dsp_params ()
  return
    {
      {
        ["type"] = "input", name = "Velocity Curve", min = 1, max = 2, default = 1, enum = true, scalepoints =
          {
            ["Yamaha P-125 {10, 95, 105, 116, 127}, {0, 105, 116, 123, 127}"] = 1,
            ["Yamaha P-125 {0, 41, 63, 81, 102, 127}, {0, 38, 61, 86, 117, 127}"] = 2,
          }
      }
    }
end

local velocity_curves =
  {
    {
      {10, 95, 105, 116, 127},
      {0, 105, 116, 123, 127}
    },
    {
      {0, 41, 63, 81, 102, 127},
      {0, 38, 61, 86, 117, 127}
    }
  }

function dsp_run (_, _, n_samples)

  local cnt = 1;
  function tx_midi (time, data)
    midiout[cnt] = {}
    midiout[cnt]["time"] = time;
    midiout[cnt]["data"] = data;
    cnt = cnt + 1;
  end

  local ctrl = CtrlPorts:array ()
  local selected = ctrl[1]
  local mapx = velocity_curves[selected][1]
  local mapy = velocity_curves[selected][2]
  function map_velocity (v)
    local i = v // (127 // (#mapx - 1)) + 1
    while true do
      if i <= 0 then
        return mapy[1]
      end
      if v >= mapx[i] then
        if i >= #mapx then
          return mapy[#mapy]
        end
        if v < mapx[i+1] then
          return mapy[i] + math.floor ((v - mapx[i]) * (mapy[i+1] - mapy[i]) / (mapx[i+1] - mapx[i]))
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
