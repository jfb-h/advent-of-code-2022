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
    them, us = strategy.(parseline(line))
    points(us) + points(play(us, them))
end

main(file) = mapreduce(points, +, readlines(file))

main("data.txt")

