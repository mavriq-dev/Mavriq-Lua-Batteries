local mv = require("mavriq")

mv.msg("Start Socket Tests\n")
mv.msg("Daytime\n")
socket = require("Socket")

host = host or "127.0.0.1"
port = port or 13
if arg then
    host = arg[1] or host
    port = arg[2] or port
end
host = socket.dns.toip(host)
udp = socket.udp()
mv.msg("Using host '" ..host.. "' and port " ..port.. "...")
udp:setpeername(host, port)
udp:settimeout(3)
sent, err = udp:send("anything")
if err then mv.msg(err) os.exit() end
dgram, err = udp:receive()
if not dgram then mv.msg(err) os.exit() end
mv.msg(dgram)

mv.msg("\n\nSimple Http Request\n")

-- load needed modules
local http = require("socket.http")
local ltn12 = require("ltn12")

local link = "http://www.example.com/private/index.html"

body, status, headers = http.request(link)
mv.printf("Body: %s, \n\n",body)
mv.printf("Status: %s, \n\n",status)
mv.printf("Headers: %s, \n\n",mv.printt(headers))


mv.msg("\n\n\nLtn12 Http Request\n")

local t = {}
local _, status, headers = http.request{
url = link,
sink = ltn12.sink.table(t)
}

mv.printf("Body: %s, \n\n",mv.printt(t))
mv.printf("Status: %s, \n\n",status)
mv.printf("Headers: %s, \n\n",mv.printt(headers))


mv.msg("\n\n\nFTP Directory Listing\n")

local ftp = require("socket.ftp")
local url = require("socket.url")

local link = "ftp://ftp.dlptest.com/"
local t = {}
local p = url.parse(link)
p.command = "NLST"
p.sink = ltn12.sink.table(t)
p.user = "dlpuser"
p.password = "rNrKYTX9g7z3RgJRmxWuGHbeu"

local _, errormessage = ftp.get(p)

mv.printf("Error Message: %s\n\n Files:\n %s",errormessage, mv.printt(t))

mv.msg("\nEnd Socket Tests\n\n")