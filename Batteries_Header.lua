os = reaper.GetOS()
extension = "dll"     --Windows
if os == "OSX64" then  extension = "dylib" -[[-macos--]] elseif os == "Other" then  extension = "so"   --[[ linux --]] end

mav_bin_path = reaper.GetResourcePath() .. "/Scripts/Mavriq ReaScript Repository/Various/Mavriq Lua Batteries/"

package.cpath = package.cpath .. ';' .. mav_bin_path .. 'bin/?.' .. extension
package.path = package.path .. ';' .. mav_bin_path .. 'lua/?.lua'

assert(package.loadlib(mav_bin_path .. "bin/lua53." .. extension,"*"))