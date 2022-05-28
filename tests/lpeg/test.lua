local mv = require("mavriq")

mv.msg("Start LPeg tests.\n")


local lpeg = require("lpeg")

mv.msg("Building Pattern: pattern = lpeg.R\"az\"^1 * -1\n")
pattern = lpeg.R"az"^1 * -1

mv.msg("pattern:match(\"hello\") :" .. pattern:match("hello") .. "\n")

local match = "nil"
if pattern:match("1 hello") then match = pattern:match("1 hello")  end
mv.msg("pattern:match(\"1 hello\") :" .. match .. "\n")


function split (s, sep)
  sep = lpeg.P(sep)
  local elem = lpeg.C((1 - sep)^0)
  local p = elem * (sep * elem)^0
  return lpeg.match(p, s)
end

mv.msg("Splitting string 'test,2,three': " .. string.format("1:'%s' 2:'%d' 3:'%s'", split("test,2,three",',')) .. "\n")

local int = lpeg.P("hello"):match("helloworld") --> a match, returns 6
mv.msg('lpeg.P("hello"):match("helloworld") = ' .. int .. "\n")


mv.msg("End LPeg tests.\n\n")