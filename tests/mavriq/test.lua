reaper.ShowConsoleMsg("Start mavriq tests.\n")

local mv = require("mavriq")
local t = {one = 1, two = 2, three = 3}

reaper.ShowConsoleMsg("printf (Print Format).\n")
mv.printf("test %s, %s\n", "1", 2)

reaper.ShowConsoleMsg("printt (Print Table).\n")
reaper.ShowConsoleMsg(mv.printt(t)..'\n')

reaper.ShowConsoleMsg("msg (Reaper.ShowConsoleMessage 'shortcode').\n")
mv.msg("Hello World"..'\n')

reaper.ShowConsoleMsg("End mavriq tests.\n\n")