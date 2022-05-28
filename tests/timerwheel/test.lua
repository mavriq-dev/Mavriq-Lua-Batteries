local mv = require("mavriq")

mv.msg("Start Timerwheel Tests\n\n")

local timerwheel = require("timerwheel.init")
local timerexpired = false
local callback = function(arg)
  mv.printf("Timer tripped with argument: %s\n\n",arg)
  timerexpired = true
end

wheel = timerwheel.new()
local id = wheel:set(2, callback, "hello world")
mv.msg("Timer running for 2 seconds.\n")

function mainloop()
  wheel:step()
  if not timerexpired  then
    reaper.defer(mainloop)
  else
    mv.msg("End Timerwheel Tests\n\n")
  end
end

mainloop()

