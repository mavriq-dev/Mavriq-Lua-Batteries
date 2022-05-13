local alien = require("alien")
libc = alien.load("msvcrt.dll")
reaper.ShowConsoleMsg(alien.platform)