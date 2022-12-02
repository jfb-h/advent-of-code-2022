function main(file)
    lines = eachline(file)

    elfs = Int[]
    accum = 0
    
    for line in lines
        if line == ""
            push!(elfs, accum)
            accum = 0
        else
            accum += parse(Int, line)
        end
    end

    value, elf = findmax(elfs)

    print("The elf with the most calories is elf $elf, carrying $value calories.")
end

main("data.txt")