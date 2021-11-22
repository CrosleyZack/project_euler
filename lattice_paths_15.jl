# PROBLEM 15 PROJECT EULER
# https://projecteuler.net/problem=15

function lattice_paths(length::Integer, height::Integer) ::Integer
    # initialize array for dynamic programming.
    grid = ones(height+1, length+1)
    # iterate from bottom right to top left.
    for x=length:-1:1, y=height:-1:1
        grid[y,x] = grid[y+1, x] + grid[y, x+1]
    end
    return grid[1,1]
end

lattice_paths(20,20)