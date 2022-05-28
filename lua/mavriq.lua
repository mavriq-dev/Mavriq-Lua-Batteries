
local mavriq = {}

local pretty = require("pl.pretty")

function mavriq.msg(str)
	reaper.ShowConsoleMsg(str)
end

function mavriq.printt(t)
	return pretty.write(t)
end

function mavriq.printf(str,...)
	reaper.ShowConsoleMsg(string.format(str,...))
end

return mavriq