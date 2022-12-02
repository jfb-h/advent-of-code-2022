abstract type Strategy end

struct Rock <: Strategy end
struct Paper <: Strategy end
struct Scissors <: Strategy end

function strategy(letter::AbstractString)
    if letter == "A" || letter == "X"
        return Rock()
    elseif letter == "B" || letter == "Y"
        return Paper()
    elseif letter == "C" || letter == "Z"
        return Scissors()
    else
        throw(ArgumentError("Invalid letter: $letter."))
    end
end

abstract type Outcome end

struct Win <: Outcome end
struct Lose <: Outcome end
struct Draw <: Outcome end

function outcome(letter::AbstractString)
    if letter == "X"
        return Lose()
    elseif letter == "Y"
        return Draw()
    elseif letter == "Z"
        return Win()
    else
        throw(ArgumentError("Invalid letter: $letter."))
    end
end

strategy(::S, ::Draw) where S <: Strategy = S()
strategy(::Rock, ::Win) = Paper()
strategy(::Paper, ::Win) = Scissors()
strategy(::Scissors, ::Win) = Rock()
strategy(::Rock, ::Lose) = Scissors()
strategy(::Paper, ::Lose) = Rock()
strategy(::Scissors, ::Lose) = Paper()

play(::Strategy, ::Strategy) = Lose()
play(::S, ::S) where S <: Strategy = Draw()
play(::Rock, ::Scissors) = Win()
play(::Paper, ::Rock) = Win()
play(::Scissors, ::Paper) = Win()

points(::Rock) = 1
points(::Paper) = 2
points(::Scissors) = 3

points(::Win) = 6
points(::Draw) = 3
points(::Lose) = 0

parseline(line) = split(line, " ")

function points(line::AbstractString)
    them, us = parseline(line)
    them = strategy(them)
    us = strategy(them, outcome(us))
    points(us) + points(play(us, them))
end

main(file) = mapreduce(points, +, readlines(file))

main("data.txt")

