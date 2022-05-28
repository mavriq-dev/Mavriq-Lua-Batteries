local mv = require("mavriq")
mv.msg("Start BinaryHeap Tests\n")

local binaryheap = require 'binaryheap'

local ROWS =  8
local COLS =  8

local unvisited = binaryheap.minUnique()

local function Cell(x, y)
  return x .. '_' .. y
end

local function Coordinates(cell)
  local x, y = cell:match('(%d+)_(%d+)')
  return x, y
end

local function neighbours(cell)
  local x, y = Coordinates(cell)
  local gen = coroutine.wrap(function()
    coroutine.yield(x - 1, y - 2)
    coroutine.yield(x - 1, y + 2)
    coroutine.yield(x + 1, y - 2)
    coroutine.yield(x + 1, y + 2)
    coroutine.yield(x - 2, y - 1)
    coroutine.yield(x - 2, y + 1)
    coroutine.yield(x + 2, y - 1)
    coroutine.yield(x + 2, y + 1)
  end)
  return coroutine.wrap(function()
    for xx, yy in gen do
      if 1 <= xx and xx <= COLS and
          1 <= yy and yy <= ROWS then
        coroutine.yield(Cell(xx, yy))
      end
    end
  end)
end

for y = 1, ROWS do
  for x = 1, COLS do
    local cell = Cell(x, y)
    unvisited:insert(1, cell)
  end
end
unvisited:update('1_1', 0)

local final_distance = {}

while unvisited:peek() do
  local current, current_distance = unvisited:peek()
  assert(not final_distance[current])
  final_distance[current] = current_distance
  unvisited:remove(current)
  -- update neighbours
  local new_distance = current_distance + 1
  for neighbour in neighbours(current) do
    if unvisited.reverse[neighbour] then
      local pos = unvisited.reverse[neighbour]
      local distance = unvisited.value[pos]
      if distance > new_distance then
        unvisited:update(neighbour, new_distance)
      end
    end
  end
end

for y = 1, ROWS do
  local row = {}
  for x = 1, COLS do
    local cell = Cell(x, y)
    local distance = final_distance[cell]
    table.insert(row, distance)
  end
  mv.msg("Row: " .. table.concat(row, ' ') .. "\n")
end

mv.msg("End BinaryHeap Tests\n")