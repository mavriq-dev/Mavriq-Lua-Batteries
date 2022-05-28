local mv = require("mavriq")

mv.msg("Start Copas Tests\n")

local copas = require("copas")
local asynchttp = require("copas.http").request

local list = {
  "https://www.google.com",
  "https://www.microsoft.com",
  "https://www.apple.com",
  "https://www.facebook.com",
  "https://www.yahoo.com",
}

local handler = function(host)
  res, err = asynchttp(host)
  mv.printf("%s done, Response Length: %s\n", host, string.len(res))
end

for _, host in ipairs(list) do copas.addthread(handler, host) end
copas.loop()

mv.msg("End Copas Tests\n\n")
