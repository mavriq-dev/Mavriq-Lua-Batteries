local mv = require("mavriq")

mv.msg("Start luasec Tests\n")

local https = require 'ssl.https' 
local ltn12 = require("ltn12")
local r, c, h, s = https.request{
    url = "https://github.com"
}

mv.msg(string.format("r:%s, c:%s, h:%s, s:%s",r,c,h,s))


mv.msg("\nEnd luasec Tests\n\n")