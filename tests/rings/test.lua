local mv = require("mavriq")

mv.msg("Start rings Tests\n")

mv.msg("Basic Test\n")
local rings = require("rings")
S = rings.new ()

data = { 12, 13, 14, }
mv.msg(
   string.format("1: %s, 2: %s, 3: %s\n",
      S:dostring ([[
      aux = {}
      for i, v in ipairs ({...}) do
         table.insert (aux, 1, v)
      end
      return table.unpack(aux)]], table.unpack(data))))

S:close ()

mv.msg("\nStable Test\n")
local count_cmd = [[
mav_bin_path = "C:/Users/geoff_obr9bt1/Desktop/reaper/Scripts/Mavriq ReaScript Repository/Various/Mavriq Lua Batteries/"
package.path = package.path .. ';' .. mav_bin_path .. 'lua/?.lua'
stable = require("stable")
count = stable.get"shared_counter" or 0
stable.set ("shared_counter", count + 1)
return count
]]

S = rings.new () -- new state
_, count = S:dostring (count_cmd) -- true, 0
mv.msg(count.. "\n")
_, count = S:dostring (count_cmd)-- true, 1
mv.msg(count.. "\n")
S:close ()

S = rings.new () -- another new state
_, count = S:dostring (count_cmd) -- true, 2
mv.msg(count.. "\n")
S:close ()

mv.msg("End rings Tests\n\n")