local mv = require("mavriq")

mv.msg("Start moses Tests\n")

mv.msg("Tables\n")
local M = require ("moses")

local t = {1,2,'hello',true}
M.clear(t) 

mv.printf("Table Cleared: %s\n",mv.printt(t))

function printpair(v,k)
	mv.printf("key:%s, value:%s\n",k,v)
end

mv.msg("For Each:\n")
M.each({4,2,1},printpair)
M.each({one = 1, two = 2, three = 3},printpair)

mv.msg("At:\n")
t = {4,5,6}
local ary = M.at(t,1,3) -- => "{4,6}"
mv.printf("Pair:%s\n",mv.printt(ary))

t = {a = 4, bb = true, ccc = false}
ary = M.at(t,'a', 'ccc') -- => "{4, false}"
mv.printf("Pair:%s\n",mv.printt(ary))

mv.msg("Count:\n")
local count = M.count({1,1,2,3,3,3,2,4,3,2},3) -- => 4
mv.printf("Count 3s:%s\n",count)
count = M.count({false, false, true},false) -- => 2
mv.printf("Count numb false:%s\n",count)

mv.msg("Map:\n")
t = M.map({1,2,3},function(v) 
  return v+10 
end) -- => "{11,12,13}"
mv.printf("Maped Values: %s\n",mv.printt(t))

mv.msg("Best:\n")
local words = {'Lua', 'Programming', 'Language'}
local word = M.best(words, function(a,b) return #a > #b end) -- => 'Programming'
mv.msg("longest: " .. word .. '\n')
word = M.best(words, function(a,b) return #a < #b end) -- => 'Lua'
mv.msg("shortest: " .. word .. '\n')

mv.msg("Sort:\n")
t = M.sort({'b','a','d','c'}, function(a,b) 
  return a:byte() > b:byte() 
end) 
mv.printf("Sorted Values: %s\n",mv.printt(t))

mv.msg("Group:\n")
t = M.groupBy({0,'a',true, false,nil,b,0.5},type) 
mv.printf("Grouped Values: %s\n",mv.printt(t))


mv.msg("End moses Tests\n\n")