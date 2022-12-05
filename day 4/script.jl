splitline(line) = split(line, ",")
parserange(s) = range(parse.(Int, split(s, "-"))...)
completeoverlap(x, y) = issubset(x, y) || issubset(y, x)
partialoverlap(x, y) = !isempty(intersect(x, y))

calculate(overlapfun, file) = mapreduce(+, eachline(file)) do line
    firstelf, secondelf  = parserange.(splitline(line))
    overlapfun(firstelf, secondelf)
end

part1(file) = calculate(completeoverlap, file)
part2(file) = calculate(partialoverlap, file)

part1("day 4/data.txt")
part2("day 4/data.txt")

