local mv = require("mavriq")

mv.msg("Start luafft tests.\n")

luafft = require("luafft")

local function next_possible_size(n)
  local m = n
  while (1) do
    m = n
    while m%2 == 0 do m = m/2 end
    while m%3 == 0 do m = m/3 end
    while m%5 == 0 do m = m/5 end
  if m <= 1 then break end
    n = n + 1
  end
  return n
end

local signal = {}
local size = next_possible_size(2*2048+1)
local frequency = 1024
local length = size / frequency

--size = next_size(size)

--Populates a list with random real numbers in complex format
function populate(list)
  for i=1,size do
	  list[i] = complex.new(math.sin(2* i/frequency * 2*math.pi) + math.sin(10* i/frequency * 2*math.pi), 0)--complex.new(math.random(), 0)
  end
end

--displays the fourier spectrum
function display(spectrum)
  local plot = ""
  for i=1,#spectrum/2 do 
    plot = plot .. string.format("%.1f Hz\t%1.1f",(i-1)/length, (spectrum[i]:abs())) 
  end
  mv.msg(string.sub(plot,0,1000))
end

--displays a single list with whatever it contains
function print_list(list)
  local plot = ""
  for i,v in ipairs(list) do 
    plot = plot .. string.format("i:%s, v:%s\n",i,v)
  end

  mv.msg(string.sub(plot,0,100))
end

--devide a list with a certain constant factor
function devide(list, factor)
  for i,v in ipairs(list) do list[i] = list[i] / factor end
end


--create a signal with two sine waves
populate(signal)

--carry out fast fourier transformation and store result in "spec"
local spec = luafft.fft(signal, false)

--now carry out inverse fast fourier transformation and store result in "reconstructed"
reconstructed = luafft.fft(spec, true)

--After retransformation, we need to devide by the data size
devide(reconstructed, size)
devide(spec, size/2)

--Displays the fourier spectrum of the audio signal
display(spec)

mv.msg("\n\nEnd luafft tests.\n\n")