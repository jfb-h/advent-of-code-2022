
data = read("day 6/data.txt", String)

alldifferent(letters, k) = length(unique(letters)) == k

function compute(letters, k)
    n = length(letters)

    x = map(1:n-k) do i
        alldifferent(letters[i:i+k-1], k)
    end

    findfirst(x) + k - 1
end

part1(data) = compute(data, 4)
part2(data) = compute(data, 14)

part1(data)
part2(data)