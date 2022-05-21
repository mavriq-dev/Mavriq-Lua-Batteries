local https = require 'ssl.https' 
local ltn12 = require("ltn12")
local r, c, h, s = https.request{
    url = "https://github.com"
}

reaper.ShowConsoleMsg(string.format("r:%s, c:%s, h:%s, s:%s",r,c,h,s))