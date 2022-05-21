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
--require("tests.cffi-lua.test")
require("tests.lpeg.test")
--require("tests.luafilesystem.test")
--require("tests.lua-cjson.test")
--require("tests.lua-zip.test")
--require("tests.luasec.test")
require("tests.MD5.test")
require("lxp")
require("luasql.odbc")
require("luasql.sqlite3")

require("luasql.mysql")
require("xavante.httpd")


