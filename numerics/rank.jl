### taken from ExpSum.jl
### ********************

struct ExpSum
    ExpList::Array{ComplexF64}
    CoeffList::Array{ComplexF64}
end

function ExpPolyConvert(ExpList::Array{ComplexF64}, CoeffList::Array{ComplexF64})
    if (length(ExpList) != length(CoeffList))
        error("Invalid Exponential Sum")
    end

    CheckList = Dict{ComplexF64,Int64}()
    # exponent + index (at the first time it appears)

    for i = 1:length(ExpList)
        if haskey(CheckList, ExpList[i])
            # if the same exponent already exists, add coefficient to the term where it first appears
            CoeffList[CheckList[ExpList[i]]] = CoeffList[CheckList[ExpList[i]]] + CoeffList[i]
            CoeffList[i] = 0
        else
            # create a new entry in the dictionary
            CheckList[ExpList[i]] = i
        end
    end

    newExpList = ComplexF64[]
    # empty list to store new ExpList values
    newCoeffList = ComplexF64[]
    # empty list to store new CoeffList values

    for i = 1:length(CoeffList)
        # make sure CoeffList has no zero
        if (CoeffList[i] != 0)
            append!(newCoeffList, CoeffList[i])
            append!(newExpList, ExpList[i])
        end
    end
    return (ExpSum(newExpList, newCoeffList))
end

# Evaluate exponential sum

function expSum(z::Number, x::ExpSum)

    z = convert(ComplexF64, z)

    expList = deepcopy(x.ExpList)
    for i = 1:length(expList)
        expList[i] *= z
    end

    ExpPolyConvert(expList, x.CoeffList)

end
### ********************
### taken from ExpSum.jl

### Ranking the terms in ExpSum
### ***************************

function rank(z::Number, x::ExpSum)
    z = convert(ComplexF64, z)
    beta = angle(z)

    InnerProductList = Array{Tuple{Float64, Int64},1}(undef,length(x.ExpList))

    for i = 1:length(x.ExpList)
        ### take exponent, convert to conjugate
        a_conj = conj(x.ExpList[i])

        ### calculate argument alpha_i, beta
        alpha = angle(a_conj)

        ### calculate modulus p_i
        p = abs(a_conj)

        ### calculate inner products
        InnerProductList[i] = (convert(Float64, p * cos(alpha - beta)), convert(Int64,i))
    end

    ### sort all inner products
    sort(InnerProductList, by = first, rev = true)

    ##print(length(InnerProductList)," ",length(x.ExpList))

    for i = 1:length(InnerProductList)
        index = InnerProductList[i][2]
        println("Rank ", i, ": ", index, "th term in the ExpSum; Exponent ", x.ExpList[index], "; Coefficient ", x.CoeffList[index])
        print("\n")
    end
end

## Take an arbitrary example as the input:
a = ExpSum([3+2im,3+3im],[5+7im,6+2im])
rank(5+1im, a)

### ***************************
### Ranking the terms in ExpSum
