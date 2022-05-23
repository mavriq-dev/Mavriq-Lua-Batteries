--[[------------------------------------------------------
  # osc send client

  This is a simple UDP client (based on lens.Socket) to send OSC messages.

  NOTE: This class needs the [lens](http://doc.lubyk.org/lens.html) library.

  ## Usage example

    local osc = require 'osc'

    client = osc.Client('127.0.0.1', 11000)

    client:send('/hello', 'lubyk', 2014)
  
--]]------------------------------------------------------
local lub     = require 'lub'
local lens    = require 'lens'
local osc     = require 'osc'
local lib     = lub.class 'osc.Client'
local mapReceive, missingEntry
local             UDP,             send,     pack =
      lens.Socket.UDP, lens.Socket.send, osc.pack

-- # Class functions

-- Create a new client connected to a given `host` and `port`.
function lib.new(host, port)
  local self = {
    socket = lens.Socket(UDP),
  }
  setmetatable(self, lib)

  self.socket:connect(host, port)

  return self
end

-- # Methods

-- Send osc message.
function lib:send(url, ...)
  send(self.socket, pack(url, ...))
end

return lib

