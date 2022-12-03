function duplicated(line)
    items = collect(line)
    l = length(items)
    firsthalf = items[begin:Int(l/2)]
    secondhalf = items[Int(l/2+1):end]
    only(intersect(firsthalf, secondhalf))
end

const PRIO = Dict(('a':'z' .=> 1:26)..., ('A':'Z' .=> 27:52)...)

priority(char::Char) = PRIO[char]
priority(line::String) = priority(duplicated(line))

part1(file) = sum(priority, eachline(file))

function part2(file)
    lines = readlines(file)
    mapreduce(+, 1:3:length(lines)) do start
        l = lines[start:start+2]
        i = only(intersect(collect.(l)...))
        priority(i)
    end
end
