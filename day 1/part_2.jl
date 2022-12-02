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

    top3 = partialsortperm(elfs, 1:3; rev=true)
    value = sum(elfs[top3])

    print("The top 3 elfs carry sweets worth $value calories.")
end

main("data.txt")