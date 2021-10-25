# PROBLEM 8 PROJECT EULER
# https://projecteuler.net/problem=8

series = """73167176531330624919225119674426574742355349194934
            96983520312774506326239578318016984801869478851843
            85861560789112949495459501737958331952853208805511
            12540698747158523863050715693290963295227443043557
            66896648950445244523161731856403098711121722383113
            62229893423380308135336276614282806444486645238749
            30358907296290491560440772390713810515859307960866
            70172427121883998797908792274921901699720888093776
            65727333001053367881220235421809751254540594752243
            52584907711670556013604839586446706324415722155397
            53697817977846174064955149290862569321978468622482
            83972241375657056057490261407972968652414535100474
            82166370484403199890008895243450658541227588666881
            16427171479924442928230863465674813919123162824586
            17866458359124566529476545682848912883142607690042
            24219022671055626321111109370544217506941658960408
            07198403850962455444362981230987879927244284909188
            84580156166097919133875499200524063689912560717606
            05886116467109405077541002256983155200055935729725
            71636269561882670428252483600823257530420752963450"""

# Get all n length sequences from sequence.
function get_substrings(string::AbstractString, n::Integer) ::Vector{<:AbstractString}
    return [SubString(string, i, (i+n-1))   # Get substring of this item and the next n-1
            for i=1:(length(string)-(n-1))] # Iterate over items from starting index 1 to the item (n-1) from the end. 
end

# Turn a string of numbers into the vector of numbers it contains.
function get_integer_series(string::AbstractString) ::Vector{<:Integer}
    # convert each item of string into a numerical digit.
    return [parse(Int64, x) for x in string]
end

# Get all input substrings as numerical vectors.
function get_n_length_series(string::AbstractString, n::Integer) ::Vector{Vector{<:Integer}}
    return [get_integer_series(x)               # get number vector of single digit numbers in string.
            for x in get_substrings(string, n)] # for each n length substring.
end

# number of sequential digits to read.
n = 13
# Get the solution.
maximum(x -> reduce(*, x), # get maximum by multiplying all the values together
        get_n_length_series(replace(series, '\n'=>""), n)) # for each sequence of n digits