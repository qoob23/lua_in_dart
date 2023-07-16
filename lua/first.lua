Class = {}
function Class:new(obj)
  obj = obj or {}
  self.__index = self
  return setmetatable(obj, self)
end

Animal = Class:new()
function Animal:say_hello()
  local i = self.kind or 'Unknown animal'
  print('Hello, I am a ' .. i)
end

Dog = Animal:new { kind = 'dog' }
Cat = Animal:new { kind = 'cat' }

local animal = Animal:new()
local dog = Dog:new()
local cat = Cat:new()

animal:say_hello()
dog:say_hello()
cat:say_hello()

-------------------------------------------

Expression = Class:new()
function Expression:evaluate()
  error('Abstract method')
end

Sum = Expression:new()
function Sum:evaluate()
  return self.a:evaluate() + self.b:evaluate()
end

Sub = Expression:new()
function Sub:evaluate()
  return self.a:evaluate() - self.b:evaluate()
end

Value = Expression:new()
function Value:evaluate()
  return self[1]
end

local expr = Sub:new { a = Value:new { 25 }, b = Sum:new { a = Value:new { 10 }, b = Value:new { 5 } } }
print(expr:evaluate())
