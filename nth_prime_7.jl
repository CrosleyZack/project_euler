# PROBLEM 7 PROJECT EULER
# https://projecteuler.net/problem=7

function max_divisor(number::Integer) ::Integer
    return Integer(floor(sqrt(number)))
end

function is_prime(number::Integer) ::Bool
    max::Integer = max_divisor(number)
    # False if any number evenly divides it.
    for x=2:max
        if number % x == 0
            return false
        end
    end
    # true otherwise.
    return true
end

function next_prime(number::Integer) ::Integer
    to_check = number
    while true
        to_check += 1
        if is_prime(to_check)
            return to_check
        end
    end
end
   

function nth_prime(number::Integer) ::Integer
    last::Integer = 1
    for i=1:number
        last = next_prime(last)
    end
    return last
end

nth_prime(10001)