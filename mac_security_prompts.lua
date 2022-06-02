os = reaper.GetOS()
extension = "dll"     --Windows
if os == "OSX64" then  extension = "dylib" elseif os == "Other" then  extension = "so" end

mav_bin_path = reaper.GetResourcePath() .. "/Scripts/Mavriq ReaScript Repository/Various/Mavriq-Lua-Batteries/"

package.cpath = package.cpath .. ';' .. mav_bin_path .. 'bin/?.' .. extension
package.path = package.path .. ';' .. mav_bin_path .. 'lua/?.lua'

assert(package.loadlib(mav_bin_path .. "bin/lua53." .. extension,"*"))

-- Run Tests
package.path = package.path .. ';' .. mav_bin_path .. '/?.lua'




require("base64")
--require("brimworks.zip")
require("cffi")
require("cjson")
require("des56")
--require("lcurl")
require("lfs")
require("lpeg")
require("luasql.firebird")
--require("luasql.mysql")
require("luasql.sqlite3")
--require("luasql.postgres")
require("lxp")
require("MD5")
require("mime.core")
require("pb")
require("rex_pcre")
require("rings")
require("rs232.core")
require("socket.core")
require("ssl")
--require("wx")
require("yaml")
require("zlib")

