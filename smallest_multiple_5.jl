function get_largest_possible_factor(n::Integer) :: Integer
    return Integer(floor(sqrt(n)))
end

function get_factor(n::Integer) :: Integer
    # Find the largest first factor which divides this value.
    # NOTE this could be sped up by only checking prime factors,
    #   but this does not impact correctness of the results
    #   for no speed up for the simplicity of this problem.
    for i=2:get_largest_possible_factor(n)
        if n % i == 0
            return i
        end
    end
    # If no factor found, its only divisible by itself and one.
    return n
end

function get_prime_factors(n::Integer) ::Vector{Integer}
    returnval :: Vector{Integer} = []
    # Continually get factors for this value, dividing by them until
    #   we reach one, indicating we have all the factors.
    while n > 1
        factor::Integer = get_factor(n)
        n = Integer(n // factor)
        push!(returnval, factor)
    end
    return returnval
end


function is_multiple_of(bottom::Integer, top::Integer) :: Dict{Integer, Integer}
    factors :: Dict{Integer, Integer} = Dict() 
    for i=bottom:top
        # Get the prime factors for i.
        primes :: Vector{Integer} = get_prime_factors(i)
        # ensure our dictionary has at least as many occurences of each number
        #   as this numbers prime set.
        for prime in primes
            occurences :: Integer = count(==(prime), primes)
            if !haskey(factors, prime) || factors[prime] < occurences
                factors[prime] = occurences
            end
        end
    end
    return factors
end


function dictionary_product(d::Dict{<:Integer, <:Integer}) :: Integer
    # Get the sum of all key-value products.
    return reduce((acc, (k,v)) -> acc * (k ^ v), d, init=1)
end

# TODO Figure out why this works..
dictionary_product(Dict(5=>1, 13=>1, 7=>1, 2=>4, 11=>1, 17=>1, 3=>2, 19=>1)).
# But this doesn't...
is_multiple_of(1,20) |> dictionary_product