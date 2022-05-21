reaper.ShowConsoleMsg("Start MD5 tests.\n")

md5 = require("md5.core")

message = md5.crypt("Marviq is da shiznat", "Mavriq")
reaper.ShowConsoleMsg(string.format("Encripted: %s ", message))
message = md5.decrypt(message, "Mavriq")
reaper.ShowConsoleMsg(string.format("\nDecripted: %s \n", message))

reaper.ShowConsoleMsg("End MD5 tests.\n\n")