# PROBLEM 6 PROJECT EULER
# https://projecteuler.net/problem=6

n = 100

# Get sum of squares of first 100 natural numbers.
function square_sum(n::Integer) ::Int128
    return sum(x^2 for x=1:n)
end 

# Get square of sum of first 100 natural numbers.
function sum_square(n::Integer) ::Int128
    return sum(1:n) ^ 2
end

sum_square(n) - square_sum(n)