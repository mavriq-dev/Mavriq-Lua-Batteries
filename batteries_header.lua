opsys = reaper.GetOS()
extension = "dll"  
if opsys == "OSX64" then  extension = "dylib" elseif opsys == "Other" then  extension = "so" end

mav_bat_path = reaper.GetResourcePath() .. "/Scripts/Mavriq ReaScript Repository/Various/Mavriq-Lua-Batteries/"

package.cpath = package.cpath .. ';' .. mav_bat_path .. 'bin/?.' .. extension
package.path = package.path .. ';' .. mav_bat_path .. 'lua/?.lua'

assert(package.loadlib(mav_bat_path .. "bin/lua53." .. extension,"*"))

