# PROBLEM 16 PROJECT EULER
# https://projecteuler.net/problem=16

"""
    pow(x::Integer, n::Integer) ::BigInt

Get the exponent x^n with no integer limit.
"""
function pow(x::Integer, n::Integer) ::BigInt
    result::BigInt = BigInt(x)^n
    return result
end

"""
Declare a partial function to parse integers. This is
    for ease of piping.
"""
parseInt = (x) -> parse(Int, x)


pow(2, 1000) |> string |> collect .|> parseInt |> sum