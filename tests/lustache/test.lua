local mv = require("mavriq")

mv.msg("Start lustache Tests\n")

local lustache = require "lustache"

view_model = {
  title = "Joe",
  calc = function ()
    return 2 + 4
  end
}

output = lustache:render("{{title}} spends {{calc}} dollars.", view_model)

mv.msg(output..'\n')

mv.msg("End lustache Tests\n\n")