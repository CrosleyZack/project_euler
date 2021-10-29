# PROBLEM 12 PROJECT EULER
# https://projecteuler.net/problem=12

# TODO figure out why this is slow. It should be really fast as written.

# Declare struct type to allow lazy iteration.
struct Triangle
end

"""
    Base.iterate(tri::Triangle)

Setup first step of iterator. This is the value 1, with the next step
    of the iteration being iteration 2 with last value 1.
"""
function Base.iterate(tri::Triangle)
    return 1, (2, 1) # the first output, and the next iteration state
end

"""
    Base.iterate(tri::Triangle, state::Tuple{<:Integer, <:Integer})

Setup next case of iterator. This adds the index onto the last value
    (creating the triangle number) and increments the following step
    index by one with this last value.
"""
function Base.iterate(tri::Triangle, state::Tuple{<:Integer, <:Integer})
    i, last = state
    return (last + i), (i + 1, last + i) # the output, and the next iteration state
end

"""
    factors(n::Integer) ::Vector{<:Integer}

Get the number of factors that a number has. Note that all factors
    will have a minimum of 2, since it adds 1 and n automatically.
    Notably this will make the output for factors(1) be incorrect.
"""
function factors(n::Integer) ::Vector{<:Integer}
    factors::Vector{Integer} = [1, n]
    # add other potential numbers.
    for i = 2:Integer(floor(n / 2))
        if n % i == 0
            push!(factors, i)
        end
    end
    return factors
end

"""
    tri_with_factors(n::Integer) ::Integer

Get the first triangle number with at least n factors.
"""
function tri_with_factors(n::Integer) ::Integer
    for i in Triangle()
        if length(factors(i)) >= n
            return i
        end
    end
end

tri_with_factors(50)
# tri_with_factors(500)