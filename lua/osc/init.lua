--[[--------------------
  # OpenSoundControl for Lua <a href="https://travis-ci.org/lubyk/osc"><img src="https://travis-ci.org/lubyk/osc.png" alt="Build Status"></a> 

  OpenSoundControl pack and unpack for Lua.

  <html><a href="https://github.com/lubyk/osc"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://s3.amazonaws.com/github/ribbons/forkme_right_green_007200.png" alt="Fork me on GitHub"></a></html>
  
  *MIT license* &copy Ross Bencina 2013, Gaspard Bucher 2014.

  Web page for [oscpack](http://www.rossbencina.com/code/oscpack).

  ## Installation
  
  With [luarocks](http://luarocks.org):

    $ luarocks install osc

  Supports sending basic Lua values and (nested) lua tables either as Array or
  Hash. A table with both numeric and string keys is treated as an array.

  WARN: This implementation does not support sending binary data.

  ## Usage example

    local osc = require 'osc'
    local data = osc.pack('/some/url', true, 2, {foo = 'bar'})
    -- ... send ... receive
    local url, a, b, c = osc.unpack(data)

--]]--------------------
local lub  = require 'lub'
local lib  = lub.Autoload 'osc'
local core = require 'osc.core'

-- nodoc
lib.pack   = core.pack
-- nodoc
lib.unpack = core.unpack

-- Current version respecting [semantic versioning](http://semver.org).
lib.VERSION = '1.0.1'

lib.DEPENDS = { -- doc
  -- Compatible with Lua 5.1 to 5.3 and LuaJIT
  "lua >= 5.1, < 5.4",
  -- Uses [Lubyk base library](http://doc.lubyk.org/lub.html)
  'lub >= 1.0.3, < 2.0',
}

-- nodoc
lib.DESCRIPTION = {
  summary = "OpenSoundControl for Lua with some wrappers around lens.Socket.",
  detailed = [[
  Simply packs/unpacks between Lua values and binary strings ready to be sent
  on the network or other transports.

  Uses Ross Bencina oscpack library.
  ]],
  homepage = "http://doc.lubyk.org/osc.html",
  author   = "Ross Bencina, Gaspard Bucher",
  license  = "MIT",
}

-- nodoc
lib.BUILD = {
  github    = 'lubyk',
  sources   = {'src/*.cpp', 'src/bind/*.cpp', 'src/bind/dub/*.cpp', 'src/vendor/osc/*.cpp'},
  includes  = {'include', 'src/bind', 'src/vendor'},
  libraries = {'stdc++'},
}

-- # Class methods

-- Pack an url with values into a binary string ready to be transmitted.
--
--   local data = osc.pack(url, value1, value2)
--
-- function lib.pack(url, ...)

-- Unpack binary data into lua values. This is a multi value return function:
--
--   local url, value1, value2 = osc.unpack(data)
--
-- function lib.unpack(data)

return lib
