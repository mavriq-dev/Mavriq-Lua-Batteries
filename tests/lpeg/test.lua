reaper.ShowConsoleMsg("Start LPeg tests.\n")


local lpeg = require("lpeg")

reaper.ShowConsoleMsg("Building Pattern: pattern = lpeg.R\"az\"^1 * -1\n")
pattern = lpeg.R"az"^1 * -1

reaper.ShowConsoleMsg("pattern:match(\"hello\") :" .. pattern:match("hello") .. "\n")

local match = "nil"
if pattern:match("1 hello") then match = pattern:match("1 hello")  end
reaper.ShowConsoleMsg("pattern:match(\"1 hello\") :" .. match .. "\n")


function split (s, sep)
  sep = lpeg.P(sep)
  local elem = lpeg.C((1 - sep)^0)
  local p = elem * (sep * elem)^0
  return lpeg.match(p, s)
end

reaper.ShowConsoleMsg("Splitting string 'test,2,three': " .. string.format("1:'%s' 2:'%d' 3:'%s'", split("test,2,three",',')) .. "\n")

local int = lpeg.P("hello"):match("helloworld") --> a match, returns 6
reaper.ShowConsoleMsg('lpeg.P("hello"):match("helloworld") = ' .. int .. "\n")


reaper.ShowConsoleMsg("End LPeg tests.\n\n")