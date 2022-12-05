splitline(line) = split(line, ",")
parserange(s) = range(parse.(Int, split(s, "-"))...)
completeoverlap(x, y) = issubset(x, y) || issubset(y, x)
partialoverlap(x, y) = !isempty(intersect(x, y))

function calculate(overlapfun, file)
    sum(eachline(file)) do line
        firstelf, secondelf  = parserange.(splitline(line))
        overlapfun(firstelf, secondelf)
    end
end

part1(file) = calculate(completeoverlap, file)
part2(file) = calculate(partialoverlap, file)

part1("data.txt")
part2("data.txt")
