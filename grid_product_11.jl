# PROBLEM 11 PROJECT EULER
# https://projecteuler.net/problem=11

grid =   """08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08
            49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00
            81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65
            52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91
            22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80
            24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50
            32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
            67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21
            24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
            21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95
            78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92
            16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57
            86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58
            19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40
            04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66
            88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69
            04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36
            20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16
            20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54
            01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48"""

"""
    grid_to_array(grid::String) ::Vector{Vector{<:Integer}}

Turn the string grid into 2d array of numbers.
"""
function grid_to_array(grid::String) ::Vector{Vector{<:Integer}}
    return [[parse(Int8, value) for value in split(row, ' ')]
            for row in split(grid, '\n')]
end

"""
    grid_cols(grid::Vector{Vector{<:Integer}}) ::Integer

Get the number of columns of the grid.
this assumes each row has the same number of columns.
"""
function grid_cols(grid::Vector{Vector{<:Integer}}) ::Integer
    return grid |> first |> length
end

"""
    grid_rows(grid::Vector{Vector{<:Integer}}) ::Integer

Get the number of rows of the grid.
"""
function grid_rows(grid::Vector{Vector{<:Integer}}) ::Integer
    return grid |> length
end


"""
    adjacencies(grid::Vector{Vector{<:Integer}}, row::Integer, column::Integer, sequence::Integer) ::Vector{Vector{<:Integer}}

Get adjacencies for a specific cell in the grid. We only look at 
    adjacencies up and to the left to prevent redundant execution.
"""
function adjacencies(grid::Vector{Vector{<:Integer}}, row::Integer, column::Integer, sequence::Integer) ::Vector{Vector{<:Integer}}
    returnval::Vector{Vector{<:Integer}} = []
    # since our sequence always includes the number (row, col), we are actually adding
    #   and subtracting by one less each time.
    len = sequence - 1
    # We don't want to spend extra computation checking things redundantly, so we 
    #   can limit this by:
    #    1. Starting from `sequence` row and `sequence` column
    #    2. Only checking for adjacencies vertically and or to the left.
    #              3   4   5
    #        IE.    \  |  /
    #                 \|/
    #             2 ---P
    #                 /
    #                /
    #               1
    #        This works as all points will be covered by this as we move down and to the right.
    # get horizontal items (1 & 2)
    if (column - len) > 0
        push!(returnval, grid[row][(column - len):column])
        # get diagonal 2.
        if row + len <= grid_rows(grid)
            #                 v Get increasing row index and decreasing column index.
            push!(returnval,[grid[r_index][column - (r_index - row)]
                                for r_index=row:(row + len)])
        end
    end
    # get vertical items (3, 4, & 5)
    if row - len > 0
        push!(returnval, [r[column] for r in grid[(row - len):row]])
        #  get diagonal 3
        if column - len > 0
            #                 v Get increasing row index and increasing column index.
            push!(returnval,[grid[r_index][column - (row - r_index)]
                                for r_index=(row - len):row])
        end
        # get diagonal 5
        if column + len <= grid_cols(grid)
            #                 v Get decreasing row index and increasing column index.
            push!(returnval,[grid[r_index][column + (row - r_index)]
                                for r_index=(row - len):row])
        end
    end
    return returnval
end


"""
    adjacent_sets(grid::Vector{Vector{<:Integer}}, sequence::Integer) ::Vector{Vector{<:Integer}}

Get all adjacent sets in this grid. This is done by iterating over
    rows and columns starting at `sequence` for both to reduce
    redundant iterations.
"""
function adjacent_sets(grid::Vector{Vector{<:Integer}}, sequence::Integer) ::Vector{Vector{<:Integer}}
    returnval::Vector{Vector{<:Integer}} = []
    # get number of rows and columns as bounds.
    rows = grid_rows(grid)
    cols = grid_cols(grid)
    # Iterate over rows and columns and add the adjacencies that are possible.
    # We don't want to spend extra computation checking things redundantly, so we 
    #   can limit this by:
    #    1. Starting from `sequence` row and `sequence` column
    #    2. Only checking for adjacencies vertically and or to the left.
    #              3   4   5
    #        IE.    \  |  /
    #                 \|/
    #             2 ---P
    #                 /
    #                /
    #               1
    #        This works as all points will be covered by this as we move down and to the right.
    for row=sequence:rows
        for column=sequence:cols
           append!(returnval, adjacencies(grid, row, column, sequence))
        end
    end
    return returnval
end

# solve the problem.
grid |> grid_to_array |> x -> adjacent_sets(x, 4) .|> prod |> maximum