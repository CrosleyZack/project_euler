# Gets the first n fibonacci numbers.
# TODO figure out how to make this lazy.
function n_fibonacci(n::Integer)
    a, b = 1, 2
    out = []
    for i=1:n
        push!(out, a)
        a, b = b, a + b
    end
    return out
end

sum(x for x in n_fibonacci(50) if (x < 4000000 && x % 2 ==0))