reaper.ShowConsoleMsg("Start Socket Tests\n")

socket = require("Socket")

host = host or "127.0.0.1"
port = port or 13
if arg then
    host = arg[1] or host
    port = arg[2] or port
end
host = socket.dns.toip(host)
udp = socket.udp()
reaper.ShowConsoleMsg("Using host '" ..host.. "' and port " ..port.. "...")
udp:setpeername(host, port)
udp:settimeout(3)
sent, err = udp:send("anything")
if err then reaper.ShowConsoleMsg(err) os.exit() end
dgram, err = udp:receive()
if not dgram then reaper.ShowConsoleMsg(err) os.exit() end
reaper.ShowConsoleMsg(dgram)

reaper.ShowConsoleMsg("End Socket Tests\n\n")