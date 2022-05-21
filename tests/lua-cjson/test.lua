reaper.ShowConsoleMsg("Start lua-cjson tests.\n")


local cjson = require("cjson")

value = { true, { foo = "bar" } }
json_text = cjson.encode(value)

reaper.ShowConsoleMsg(string.format("Encoded value from { true, { foo = \"bar\" } }: %s \n", value))

json_text = '[ true, { "foo": "bar" } ]'
value = cjson.decode(json_text)

reaper.ShowConsoleMsg(string.format("Decoded value from [ true, { foo = \"bar\" } ]: %s \n", value))

reaper.ShowConsoleMsg("End lua-cjson tests.\n\n")