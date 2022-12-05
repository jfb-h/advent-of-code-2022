function parseproblem(lines)
    i = findfirst(==(""), lines)
    lines[begin:i-2], lines[i+1:end]
end

nstacks(line) = div(length(line) + 1, 4)

function splitrows(line; nstacks=9, stackwidth=4)
    map(1:stackwidth:nstacks*stackwidth) do i
        @views line[i:i+2]
    end
end

function parseitem(item)
    item == "   " && return nothing
    replace(item, r"\[|\]" => "")
end

function rows2matrix(lines)
    m = permutedims(hcat(splitrows.(lines)...)) 
    parseitem.(m)
end

parsestacks(lines) = [filter(!isnothing, col) for col in eachcol(rows2matrix(lines))]

function parsemoves(line)
    l = replace(line, "move " => "", "from " => "", "to " => "")
    Tuple(parse.(Int, split(l, " ")))
end

function popk!(x, k)
    y = Vector{eltype(x)}()
    for _ in 1:k
        push!(y, popfirst!(x))
    end
    y
end

function move!(stacks, instruction; rev=true)
    k, from, to = instruction
    k > 0 || return
    x = popk!(stacks[from], k)
    x = rev ? reverse(x) : x
    stacks[to] = append!(x, stacks[to])
end

function solve(file; rev)
    lines = readlines(file)
    setup, moves = parseproblem(lines)
    stacks = parsestacks(setup)
    for line in moves 
        #display(stacks)
        #display(line)
        move!(stacks, parsemoves(line); rev)
    end
    string(first.(stacks)...)
end

part1(file) = solve(file, rev=true)
part2(file) = solve(file, rev=false)

