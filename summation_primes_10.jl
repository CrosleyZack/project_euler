# PROBLEM 10 PROJECT EULER
# https://projecteuler.net/problem=10

"""
    max_divisor(number::Integer) ::Integer

Get the max divisor we need to check in order to determine if a
    number is prime. This is because we only have to check
    up to the sqrt of the number, as any number larger than 
    that would have to be multiplied with a number less than
    the square root to make that final value.
"""
function max_divisor(number::Integer) ::Integer
    return floor(sqrt(number))
end

"""
    is_prime(number::Integer) ::Bool

Checks if a number is prime. Checks 2 and odd values less than
    or equal to the sqrt of the number for efficiency.
"""
function is_prime(number::Integer) ::Bool
    # special case check if number is divisible by 2.
    #   Since this is the only prime even number, once we
    #   check this, we can skip all other even numbers.
    #   We do need to also check that this number is not
    #   equal to 2, which is a prime number.
    if number % 2 == 0 && number != 2
        return false
    end
    # check if any odd numbers below or equal to sqrt 
    #   evenly divide this number.
    for x=3:max_divisor(number)
        if number % x == 0
            return false
        end
    end
    # If we haven't found any divisors, return true.
    return true
end

"""
    get_primes(number::Integer) ::Vector{<:Integer}

Get all primes less than or equal to number.
"""
function get_primes(number::Integer) ::Vector{<:Integer}
    return collect(x for x=2:number if is_prime(x))
end

# Get first two million primes
2000000 |> get_primes |> sum