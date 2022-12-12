using Graphs

function readmatrix(file)
    lines = readlines(file)
    mat = mapreduce(hcat, lines) do line
        first.(split(line, ""))
    end
    permutedims(mat)
end

step_valid(a, b) = b - a <= 1

findstart(grid) = LinearIndices(grid)[findfirst(grid .== 'S')]
findend(grid) = LinearIndices(grid)[findfirst(grid .== 'E')]

function makegraph(matrix)
    g = Graphs.grid(size(matrix))
    for v in vertices(g)
        nbs = neighbors(g, v)
        for n in nbs
            if !step_valid(matrix[v], matrix[n])
                rem_edge!(g, v, n)
            end
        end
    end
    g
end

function shortest(grid)
    g = makegraph(grid)
    from, to = findstart(grid), findend(grid)
    path = Graphs.a_star(g, from, to)
    length(path)
end

part1(file) = shortest(readmatrix(file))