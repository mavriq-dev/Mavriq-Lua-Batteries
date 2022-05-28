os = reaper.GetOS()
extension = "dll"     --Windows
if os == "OSX64" then  extension = "dylib" -[[-macos--]] elseif os == "Other" then  extension = "so"   --[[ linux --]] end

mav_bin_path = reaper.GetResourcePath() .. "/Scripts/Mavriq ReaScript Repository/Various/Mavriq-Lua-Batteries/"

package.cpath = package.cpath .. ';' .. mav_bin_path .. 'bin/?.' .. extension
package.path = package.path .. ';' .. mav_bin_path .. 'lua/?.lua'

assert(package.loadlib(mav_bin_path .. "bin/lua53." .. extension,"*"))

-- Run Tests
package.path = package.path .. ';' .. mav_bin_path .. '/?.lua'

require("tests.socket.test")
require("tests.timerwheel.test")
require("tests.luafilesystem.test")
require("tests.binaryheap.test")
require("tests.copas.test")
require("tests.lbase64.test")
require("tests.rings.test")
require("tests.cffi-lua.test")
require("tests.luafft.test")
require("tests.middleclass.test")
require("tests.lustache.test")
require("tests.moses.test")
require("tests.MD5.test")
require("tests.lyaml.test")
require("tests.lua-protobuf.test")
require("tests.luasec.test")
require("tests.lua-zip.test")
require("tests.lpeg.test")
require("tests.lua-cjson.test")
require("tests.mavriq.test")
