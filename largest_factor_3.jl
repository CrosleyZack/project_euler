# PROBLEM 3 PROJECT EULER
# https://projecteuler.net/problem=3

# Check if a number is a multiple of another number.
function is_multiple(number::Integer, divisor::Integer)
    return number % divisor == 0
end

function largest_possible_factor(number::Integer)
    return floor(sqrt(number))
end

function is_prime(number::Integer)
    # Check first if this is a multiple of two, as that
    #   lets us skip a lot of numbers
    if is_multiple(number, 2)
        return true
    end
    # Get largest possible factor, floor(sqrt(number))
    maximum = sqrt(number)
    if isinteger(maximum)
        # We already have our answer! Hurray!
        return true
    else
        maximum = Integer(floor(maximum))
    end
    # Check if any of the odd values from 3 to maximum are a factor.
    return !any(is_multiple(number, x) for x=3:2:maximum)
end

function largest_factor(number::Integer)
    maximum = Integer(largest_possible_factor(number))
    return first(x for x=reverse(3:2:maximum) if (is_multiple(number, x) && is_prime(x)))
end

largest_factor(600851475143)