os = reaper.GetOS()
extension = "dll"     --Windows
if os == "OSX64" then  extension = "dylib" -[[-macos--]] elseif os == "Other" then  extension = "so"   --[[ linux --]] end

mav_bin_path = reaper.GetResourcePath() .. "/Scripts/Mavriq ReaScript Repository/Various/Mavriq Lua Batteries/"

package.cpath = package.cpath .. ';' .. mav_bin_path .. 'bin/?.' .. extension
package.path = package.path .. ';' .. mav_bin_path .. 'lua/?.lua'

assert(package.loadlib(mav_bin_path .. "bin/lua53." .. extension,"*"))



-- Run Tests
package.path = package.path .. ';' .. mav_bin_path .. '/?.lua'

require("tests.socket.test")
require("tests.cffi-lua.test")



local lfs = require("lfs")
local result = lfs.currentdir()
reaper.ShowConsoleMsg(result)

local lpeg = require("lpeg")

local int = lpeg.P("hello"):match("helloworld") --> a match, returns 6
reaper.ShowConsoleMsg(int)

require("cjson")

local json_safe = require("cjson.safe")
local zip = require("brimworks.zip")