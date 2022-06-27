
local mavriq = {}

local pretty = require("pl.pretty")

local stdprint = print

function mavriq.msg(str)
	reaper.ShowConsoleMsg(str)
end

function mavriq.printt(t)
	return pretty.write(t)
end

function mavriq.printf(str,...)
	reaper.ShowConsoleMsg(string.format(str,...))
end

function mavriq.redirectprint()
	function print(...) 
	    local t = {}
	    for i, v in ipairs( { ... } ) do
	      t[i] = tostring( v )
	    end
	    reaper.ShowConsoleMsg( table.concat(t, "\n" ) .. "\n" )
	end
end

function mavriq.stdprint()
	print = stdprint
end


local FILEcopy = {
write = function(self, ...) 
        local t = {}
    for i, v in ipairs( { ... } ) do
      t[i] = tostring( v )
    end
    reaper.ShowConsoleMsg( table.concat(t, "") )
 end,
 flush = function(self,...)
 end,
}
FILEcopy.__index = FILEcopy

function mavriq.redirectstdout()
	io.stdout = setmetatable({mode = "stdout"}, FILEcopy)
end

function mavriq.redirectoutput()
	io.output = setmetatable({mode = "output"}, FILEcopy)
end

return mavriq