using CSV, Tables

readdata(file) = CSV.File(file; header=["first", "second"], delim=',') |> Tables.rowtable
parserange(s) = range(parse.(Int, split(s, "-"))...)
completeoverlap(x, y) = issubset(x, y) || issubset(y, x)
partialoverlap(x, y) = !isempty(intersect(x, y))

calculate(overlapfun, file) = mapreduce(+, readdata(file)) do row
    overlapfun(parserange(row.first), parserange(row.second))
end

part1(file) = calculate(completeoverlap, file)
part2(file) = calculate(partialoverlap, file)

part1("data.txt")
part2("data.txt")

