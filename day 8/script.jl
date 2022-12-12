function parse_grid(file)
    lines = readlines(file)
    mapreduce(hcat, lines) do line
        parse.(Int, split(line, ""))
    end |> permutedims
end

function isvisible_grid(grid)::Matrix{Bool} end

function update_isvisible_sequence!(isvis, seq)
    current_max = first(seq)
    for i in eachindex(seq)
        isvis[i] && continue
        current_max == 9 && break
        if seq[i] > current_max
            isvis[i] = true
            current_max = seq[i]
        end        
    end
    isvis
end

