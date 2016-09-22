local options = require 'mp.options'

local osd_ass_cc = mp.get_property_osd('osd-ass-cc/0')
local chat
local display

local opt = {
  toggle_key = 'c',
  enable_position_binds = true,
  osd_position = 6, -- osd_position uses 'numpad values'
  message_duration = 10, -- in seconds
  message_limit = 10,
  update_interval = 0.3,
  redraw_interval = 10.0,

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
	if s:lower() == 'test' then
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
	-- if chat == nil or chat.display:empty() then return end
	local message = ''
	if not has_vo() then return end
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
	for idx=display.head, display.tail do
		if idx - display.head == opt.message_limit then
			display:lpop()
			break
		end
		local msg = display[idx]
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
  local message = {}
  message.user = user
  message.text = text
  display:rpush(message)
  ev_redraw()
end

mp.register_script_message("danmu", danmu)

display = Deque.new()
