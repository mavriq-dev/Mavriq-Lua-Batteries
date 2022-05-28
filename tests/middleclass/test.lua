local mv = require("mavriq")

mv.msg("Start middleclass Tests\n\n")


local class = require('middleclass').class


mv.msg("Inheretance \n")
Person = class('Person') --this is the same as class('Person', Object) or Object:subclass('Person')

function Person:initialize(name)
	self.name = name
end

function Person:speak()
	return 'Hi, I am ' .. self.name ..'.\n'
end

AgedPerson = class('AgedPerson', Person) -- or Person:subclass('AgedPerson')
AgedPerson.static.ADULT_AGE = 18 --this is a class variable

function AgedPerson:initialize(name, age)
	Person.initialize(self, name) -- this calls the parent's constructor (Person.initialize) on self
	self.age = age
end

function AgedPerson:speak()
	local hi = Person.speak(self) -- "Hi, I am xx."
	if self.age < AgedPerson.ADULT_AGE then -- accessing a class variable from an instance method
		return hi .. 'I am underaged.\n'
	else
		return hi .. 'I am an adult.\n'
	end
end

local p1 = AgedPerson:new('Billy the Kid', 13) -- this is equivalent to AgedPerson('Billy the Kid', 13) - the :new part is implicit
local p2 = AgedPerson:new('Luke Skywalker', 21)
mv.msg(p1:speak())
mv.msg(p2:speak())

mv.msg("\nMetamethods \n")

Point = class('Point')

function Point:initialize(x,y)
	self.x = x
	self.y = y
end

function Point:__tostring()
	return 'Point: [' .. tostring(self.x) .. ', ' .. tostring(self.y) .. ']'
end

p1 = Point(100, 200)
p2 = Point(35, -10)
mv.printf("Point automatically converted to string:%s\n",p1)
mv.printf("Point automatically converted to string:%s\n",p2)

mv.msg("\nMixins \n")

HasWings = { -- HasWings is a module, not a class. It can be "included" into classes
fly = function(self)
	return 'flap flap flap I am a ' .. self.class.name
end
}

Animal = class('Animal')

Insect = class('Insect', Animal) -- or Animal:subclass('Insect')

Worm = class('Worm', Insect) -- worms don't have wings

Bee = class('Bee', Insect)
Bee:include(HasWings) --Bees have wings. This adds fly() to Bee

Mammal = class('Mammal', Animal)

Fox = class('Fox', Mammal) -- foxes don't have wings, but are mammals

Bat = class('Bat', Mammal)
Bat:include(HasWings) --Bats have wings, too.

local bee = Bee() -- or Bee:new()
local bat = Bat() -- or Bat:new()
mv.msg(bee:fly()..'\n')
mv.msg(bat:fly()..'\n')


mv.msg("\nEnd middleclass Tests\n\n")