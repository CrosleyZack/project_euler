# PROBLEM 31 PROJECT EULER
# https://projecteuler.net/problem=31

# Define the coins and their values in pence
coins = Dict(:pence1 => 1, :pence2 => 2, :pence5 => 5, :pence10 => 10,
             :pence20 => 20, :pence50 => 50, :Pound1 => 100, :Pound2 => 200)

# Get the next denomination smaller than this one.
function next_denom(this_denom::Integer)
    if this_denom <= 1
        return nothing
    end
    return max((x for x in values(coins) if x < this_denom)...)
end

# Get the number of options to create the taget value from the denominations in coins.
function num_options(target::Number, denom::Integer)
    # Get the next denomination below this one, nothing if we are already at one pence.
    next = next_denom(denom)
    # Get the max number of this denomination that can go into our remaining value.
    max_count = target // denom
    count = 0
    # for each number from 0 to the max denomination, get the number of combinations
    #   of coins that make the total desired value.
    for i=0:max_count
        remainder = target - (i * denom)
        # If we fully account for the value, indicate one combination of coins found.
        if remainder == 0
            count += 1
        # If we have remaining value and a next currency below this one, recurse.
        elseif !isnothing(next)
            count += num_options(remainder, next)
        end
    end
    return count
end

# calculate solution
num_options(200, 200)