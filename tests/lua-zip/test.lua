reaper.ShowConsoleMsg("Start lua-zip tests.\n")


local zip = require("brimworks.zip")
local lfs = require("lfs")
local os = require("os")

local scriptdir =  string.sub(debug.getinfo(1).source, 2, string.len("/test.lua") * -1)

lfs.chdir(scriptdir)

local result = lfs.currentdir()
reaper.ShowConsoleMsg("Current Script Directory is: " .. result .. "\n")


local ar = assert(zip.open("test2.zip",  zip.OR(zip.CREATE, zip.EXCL)))
ar:add("dir/add.txt", "string", "Contents")
ar:add("dir/test.lua", "file", "test.lua")
ar:add("dir/test.zip", "file", "test.zip")
ar:close()

os.remove("test2.zip")


reaper.ShowConsoleMsg("End lua-zip tests.\n\n")