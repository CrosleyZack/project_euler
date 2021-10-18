using Combinatorics

function is_palindrome(x)
    s = string(x)
    for (a, b) in zip(s, reverse(s))
        if a != b
            return false
        end
    end
    return true
end

function possible_operands(x)
    return combinations(x:-1:1,2)
end

function largest_palindrome()
    largest = -1
    for (op1, op2) in possible_operands(999)
        prod = op1 * op2
        if is_palindrome(prod) && prod > largest
            largest = prod
        end
    end
    return largest
end

largest_palindrome()