# PROBLEM 1 PROJECT EULER
# https://projecteuler.net/problem=1

# Check if a number is a multiple of another number.
function is_multiple(number::Integer, divisor::Integer)
    return number % divisor == 0
end

# Get numbers which are multiples of one or more divisors.
function get_multiples(below::Integer, divisors::Vector{<:Integer})
    return [x for x=1:(below-1) if any(is_multiple(x, d) for d in divisors)]
end

# Calculate solution.
sum(get_multiples(1000, [3, 5]))