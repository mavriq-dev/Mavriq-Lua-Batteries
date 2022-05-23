--[[------------------------------------------------------
  # osc receive server

  This is a simple UDP server (based on lens.Socket) to receive OSC messages.

  The server must be created and run inside lens.Scheduler (see example below).

  NOTE: This class needs the [lens](http://doc.lubyk.org/lens.html) library.

  ## Usage example

    local lens = require 'lens'
    -- Using live coding
    lens.run(function() lens.FileWatch() end)

    local osc = require 'osc'

    server = server or osc.Server(11000)

    function server:receive(url, ...)
      print(url, ...)
    end
  
--]]------------------------------------------------------
local lub     = require 'lub'
local lens    = require 'lens'
local osc     = require 'osc'
local lib     = lub.class 'osc.Server'
local mapReceive, missingEntry
local             UDP,             recvMessage,     unpack =
      lens.Socket.UDP, lens.Socket.recvMessage, osc.unpack

-- Create a new server. If `port` is '0', a random available port will be chosen.
-- If an optional `map` table is provided, it is used to trigger functions from
-- message url (see #map).
function lib.new(port, map)
  local self = {
    port   = port,
    socket = lens.Socket(UDP),
  }
  setmetatable(self, lib)

  self.thread = lens.Thread(function()
    local srv = self.socket
    while true do
      self:receive(unpack(recvMessage(srv)))
    end
  end)
  self.socket:bind('*', port)

  if map then
    self:map(map)
  end

  return self
end

-- Trigger functions from message urls. Calling this function overwrites the
-- #receive callback.
--
-- Example:
--
--   server:map {
--     ['/1/fader1'] = function(url, value)
--       print('HEY, fader 1 changed', value)
--     end,
--
--     ['/1/pad1'] = function(url, x, y)
--       box:move(x, y)
--     end,
--
--     unknown = function(url, ...)
--       print('Missing entry in map table', url, ...)
--     end,
--   }
--
--  The 'unknown' entry is used to map all urls not present in the table.
function lib:map(map)
  self.map = map
  map.unknown = map.unknown or missingEntry
  self.receive = mapReceive
end

-- # Callback

-- This callback is called when osc messages arrive. If #map is used, this
-- callback is changed.
function lib:receive(url, ...)
  print(url, ...)
end

------------------------------------------------------------ PRIVATE
function mapReceive(self, url, ...)
  local map = self.map
  local func = map[url] or map.unknown
  func(...)
end

function missingEntry(...)
  print('Missing entry in map table', ...)
end

return lib

