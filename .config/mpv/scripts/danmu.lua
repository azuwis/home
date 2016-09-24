local options = require 'mp.options'

local osd_ass_cc = mp.get_property_osd('osd-ass-cc/0')
local enabled = true
local messages
local streamer

local opt = {
  redraw_key = 'c',
  toggle_key = 'C',
  enable_position_binds = true,
  osd_position = 6, -- osd_position uses 'numpad values'
  message_limit = 10,
  redraw_interval = 20.0,

  -- text styling
  font = 'Noto Sans CJK SC',
  font_size = 8,
  font_colour = 'FFFFFF',
  border_size = 0.5,
  border_colour = '000000',
  alpha = '11',
  streamer_font_colour = '0000FF',
  streamer_border_colour = '111111',
}
options.read_options(opt)

local Deque = {}
Deque.__index = Deque

function Deque.new()
  local self = setmetatable({}, Deque)
  self.head = 0
  self.tail = -1
  return self
end

function Deque:flush()
  while not self:empty() do
    self:lpop()
  end
  self.head = 0
  self.tail = -1
end

function Deque:lpush(value)
  local head = self.head - 1
  self.head = head
  self[head] = value
end

function Deque:rpush(value)
  local tail = self.tail + 1
  self.tail = tail
  self[tail] = value
end

function Deque:lpeek()
  if self:empty() then error('empty deque') end
  return self[self.head]
end

function Deque:lpop()
  if self:empty() then error('empty deque') end
  local head = self.head
  local value = self[head]
  self[head] = nil
  self.head = head + 1
  return value
end

function Deque:rpeek()
  if self:empty() then error('empty deque') end
  return self[self.tail]
end

function Deque:rpop()
  if self:empty() then error('empty deque') end
  local tail = self.tail
  local value = self[tail]
  self[tail] = nil
  self.tail = tail - 1
  return value
end

function Deque:length()
  if self.head > self.tail then
    return 0
  else
    return self.tail - self.head + 1
  end
end

function Deque:empty()
  return self:length() == 0
end

function has_vo()
  local vo_conf = mp.get_property("vo-configured")
  local video = mp.get_property("video")
  return vo_conf == "yes" and (video and video ~= "no" and video ~= "")
end

function txt_username(s)
  if s == nil then
    return ''
  end
  if s == streamer then
    s = string.format(
      '{\\1c&H%s&}{\\3c&H%s&}%s:{\\1c&H%s&}{\\3c&H%s&}',
      opt.streamer_font_colour,
      opt.streamer_border_colour,
      s,
      opt.font_colour,
      opt.border_colour
    )
  else
    s = s .. ':'
  end
  return string.format('{\\b1}%s{\\b0}', s)
end

function ev_redraw()
  if enabled == false or messages:empty() then return end
  local message = ''
  -- if not has_vo() then return end
  message = string.format(
    '%s{\\an%d}{\\fs%d}{\\fn%s}{\\bord%f}{\\3c&H%s&}{\\1c&H%s&}{\\alpha&H%s&}',
    osd_ass_cc,
    opt.osd_position,
    opt.font_size,
    opt.font,
    opt.border_size,
    opt.border_colour,
    opt.font_colour,
    opt.alpha
  )
  for idx=messages.head, messages.tail do
    if idx - messages.head == opt.message_limit then
      messages:lpop()
      break
    end
    local msg = messages[idx]
    message = message .. string.format(
      '%s %s\\N',
      txt_username(msg.user),
      msg.text
                                      )
  end
  mp.osd_message(message, opt.redraw_interval + 0.1)
end

function danmu(user, text)
  -- mp.msg.info(msg)
  messages:rpush({user=user, text=text})
  ev_redraw()
end

function ev_toggle()
  enabled = not(enabled)
  if enabled == false then
    mp.osd_message('Danmu: disabled')
  end
  ev_redraw()
end

function ev_start_file()
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
      messages = Deque.new()
      mp.register_script_message('danmu', danmu)
      mp.add_key_binding(opt.redraw_key, 'redraw', ev_redraw, {repeatable=false})
      mp.add_key_binding(opt.toggle_key, 'toggle', ev_toggle, {repeatable=false})
      break
    end
  end
end
mp.register_event('start-file', ev_start_file)

function ev_end_file()
  if messages ~= nil then
    messages:flush()
  end
  mp.unregister_script_message('danmu')
  mp.remove_key_binding('redraw')
  mp.remove_key_binding('toggle')
end
mp.register_event('end-file', ev_end_file)
