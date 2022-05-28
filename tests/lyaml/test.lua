local mv = require("mavriq")

mv.msg("Start lyaml Tests\n")

local lyaml = require("lyaml.init")

local t = lyaml.load("foo: bar")
--> { foo = "bar" }

mv.msg("One entry:"..mv.printt(t)..'\n')

t = lyaml.load("foo: bar", { all = true })
--> { { foo = "bar" } }

mv.msg("One wrapped:"..mv.printt(t)..'\n')

multi_doc_yaml = [[
---
one
...
---
two
...
]]

t = lyaml.load(multi_doc_yaml)
--> "one"
mv.msg("Multidoc:"..mv.printt(t)..'\n')

t = lyaml.load(multi_doc_yaml, { all = true })
--> { "one", "two" }
mv.msg("Multidoc all:"..mv.printt(t)..'\n')


mv.msg("End lyaml Tests\n\n")