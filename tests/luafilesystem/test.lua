reaper.ShowConsoleMsg("Start LuaFileSystem tests.\n")

function listdir ()
	for file in lfs.dir(".") do 
	    if file ~= "." and file ~= ".." then
			reaper.ShowConsoleMsg(file .. "\t")
	    end
	end
	reaper.ShowConsoleMsg("\n")
end

local lfs = require("lfs")

lfs.chdir (reaper.GetResourcePath())
local result = lfs.currentdir()
reaper.ShowConsoleMsg("Current Working Directory is: " .. result .. "\n")

lfs.chdir (reaper.GetResourcePath() .. "/Scripts")

local result = lfs.currentdir()
reaper.ShowConsoleMsg("Current Working Directory is: " .. result .. "\n")

reaper.ShowConsoleMsg("Current directory list\n")
listdir()
reaper.ShowConsoleMsg("\n\nmkdir test\n")
lfs.mkdir("test")
reaper.ShowConsoleMsg("Current directory list\n")
listdir()
reaper.ShowConsoleMsg("\n\nrmdir test\n")
lfs.rmdir("test")
reaper.ShowConsoleMsg("Current directory list\n")
listdir()

lfs.mkdir("test")
reaper.ShowConsoleMsg("End LuaFileSystem tests.\n\n")

