local mv = require("mavriq")

mv.msg("Start LuaFileSystem tests.\n")

function listdir ()
	for file in lfs.dir(".") do 
	    if file ~= "." and file ~= ".." then
			mv.msg(file .. "\t")
	    end
	end
	mv.msg("\n")
end

local lfs = require("lfs")

lfs.chdir (reaper.GetResourcePath())
local result = lfs.currentdir()
mv.msg("Current Working Directory is: " .. result .. "\n")

lfs.chdir (reaper.GetResourcePath() .. "/Scripts")

mv.msg("Changing Directory\n")

local result = lfs.currentdir()
mv.msg("Current Working Directory is: " .. result .. "\n")

mv.msg("Current directory list\n")
listdir()
mv.msg("\n\nmkdir test\n")
lfs.mkdir("test")
mv.msg("Current directory list\n")
listdir()
mv.msg("\n\nrmdir test\n")
lfs.rmdir("test")
mv.msg("Current directory list\n")
listdir()

lfs.mkdir("test")
mv.msg("End LuaFileSystem tests.\n\n")

