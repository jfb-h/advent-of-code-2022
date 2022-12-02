lines = readlines("data.txt")

parseline(l) = split(l, " ")

strategypoints = Dict(
    "X" => 1,
    "Y" => 2,
    "Z" => 3, 
)

function outcomepoints(them, us)
    lose, draw, win = 0, 3, 6

    if us == "X" && them == "A"
        return draw
    elseif us == "X" && them == "B"
        return lose
    elseif us == "X" && them == "C"
        return win
    elseif us == "Y" && them == "A"
        return win
    elseif us == "Y" && them == "B"
        return draw
    elseif us == "Y" && them == "C"
        return lose
    elseif us == "Z" && them == "A"
        return lose
    elseif us == "Z" && them == "B"
        return win
    elseif us == "Z" && them == "C"
        return draw
    end
end

function getstrategy(them, outcome)
    if them == "A" && outcome == "X" # lose
        return "Z" # Scissors in the old system
    elseif them == "A" && outcome == "Y" # draw
        return "X" # Rock in the old system
    elseif them == "A" && outcome == "Z" # win
        return "Y" # Paper in the old system 
    elseif them == "B" && outcome == "X" # lose
        return "X"
    elseif them == "B" && outcome == "Y" # draw
        return "Y"
    elseif them == "B" && outcome == "Z" # win
        return "Z"
    elseif them == "C" && outcome == "X"
        return "Y"
    elseif them == "C" && outcome == "Y"
        return "Z"
    elseif them == "C" && outcome == "Z"
        return "X"
    end
end

function points(line)
    them, us = parseline(line)
    return strategypoints[us] + outcomepoints(them, getstrategy(them, us))
end

sum(points.(lines))