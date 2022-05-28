local mv = require("mavriq")
mv.msg("Start lua-cjson tests.\n")


local cjson = require("cjson")

value = { true, { foo = "bar" } }
json_text = cjson.encode(value)

mv.printf("Encoded value from { true, { foo = \"bar\" } }: %s \n", value)

json_text = '[ true, { "foo": "bar" } ]'
value = cjson.decode(json_text)

mv.printf("Decoded value from [ true, { foo = \"bar\" } ]: %s \n", value)

mv.msg("End lua-cjson tests.\n\n")