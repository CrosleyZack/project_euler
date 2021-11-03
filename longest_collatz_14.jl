# PROBLEM 14 PROJECT EULER
# https://projecteuler.net/problem=14
# Which starting number, under one million, produces the longest collatz chain?

"""
    next_collatz(number::Integer) ::Integer

Get the next collatz number after this one.
"""
function next_collatz(number::Integer) ::Integer
    # n → n/2 (n is even)
    if number % 2 == 0
        return number // 2
    end
    # n → 3n + 1 (n is odd)
    return 3 * number + 1
end


"""
    collatz_sequence(number::Integer) ::Vector{<:Integer}

Get the collatz sequence for this number.
"""
function collatz_sequence(number::Integer) ::Vector{<:Integer}
    returnval::Vector{Int64} = [number]
    while number != 1
        number = next_collatz(number)
        push!(returnval, number)
    end
    return returnval
end


"""
    get_collatz_length(number::Integer) ::Integer

Get the length of the collatz length for this number.
"""
function get_collatz_length(number::Integer) ::Integer
    return length(collatz_sequence(number))
end


"""
    maxkey(coll::Vector{<:Any}, f::Function)

Get the item from a collection that returns the largest value from the function.
"""
function maxkey(coll::AbstractVector, f::Function) ::Any
    returnval::Any = nothing
    maxval::Number = typemin(Int64)
    # Iterate over items and find the largest value outputted by the function.
    for item in coll
        thisval::Number = f(item)
        if thisval > maxval
            maxval = thisval
            returnval = item
        end
    end
    return returnval
end


maxkey(1:999999, get_collatz_length)