# PROBLEM 9 PROJECT EULER
# https://projecteuler.net/problem=9

"""
    is_pythagorean_triple(x::Integer, y::Integer, z::Integer) ::Bool

Checks if the three numbers provided form a pythagorean triple. This is an 
    ordered check, assuming the last item is the right hand of the equality.
"""
function is_pythagorean_triple(x::Integer, y::Integer, z::Integer) ::Bool
    return x^2 + y^2 == z^2
end

"""
    get_candidates(n::Integer) ::Vector{Tuple{<:Integer, <:Integer, <:Integer}}

Get all possible a,b,c values for a+b+c == n. This does not solve the equation,
but uses the formulas to receive values that we know could potentially 
fit the equality.
"""
function get_candidates(n::Integer) ::Vector{Tuple{<:Integer, <:Integer, <:Integer}}
    returnval::Vector{Tuple{<:Integer, <:Integer, <:Integer}} = []
    # iterate over possible values for C. Since a^2 + b^2 = c^2, its stands
    #   that if a=b=c this won't be true. Thus we only need to iterate from
    #   c=(n/3), a=b=c to c=(n-2), a=b=1. We may be able to shrink this
    #   range even further with more advanced code, but this is a simple way
    #   to shrink the search space.
    for c=ceil(n / 3):(n-2)
        # Get the maximum value for a. a^2 + b^2 = c^2 cannot be true if a > c, and
        #   since b >= 1 we know a can be at most (n-(c+1)). We want to avoid going
        #   all the way to a=(n-(c+1)), b=1 as we are starting from a=1. Since
        #   addition is commutative, checking a=x,b=y and b=x,a=y is redundant.
        #   We only need to go therefore to a=(n-c)/2, as at that point b has gone
        #   from (n-(c+1)) to (n-c)/2, covering all value.
        max_value = floor((n-c)/2)
        # iterate over possible a, b values as described above.
        for a=1:max_value
            push!(returnval, (a, (n-(a+c)), c))
        end
    end
    return returnval
end

"""
    get_first_pythagorean_triple_with_sum(n::Integer) ::Tuple{<:Integer, <:Integer, <:Integer}

Get first a,b,c value that satisfies pythagorean equality and
sums to value n.
"""
function get_first_pythagorean_triple_with_sum(n::Integer) ::Tuple{<:Integer, <:Integer, <:Integer}
    # for each candidate value, return if it is a pythagorean triple.
    #   We only need the the first one, as we are only looking for a
    #   single satisfying triple.
    for candidate in get_candidates(n)
        if is_pythagorean_triple(candidate...)
            return candidate
        end
    end
    # if we didn't find a value, return nothing
    return nothing
end

# Get produce abc.
1000 |> get_first_pythagorean_triple_with_sum |> (x -> reduce(*, x))