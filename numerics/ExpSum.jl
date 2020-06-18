using SymPy

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

(f::ExpSum)(z::Number) = expSum(z, f)

# SymPy version

function expSumSym(z::Sym, x::ExpSum)
                
    symList = 0
    for i = 1:length(x.ExpList)
        symList += x.CoeffList[i] * exp(x.ExpList[i] * z)
    end
    
    return symList
    
end

(f::ExpSum)(z::Sym) = expSumSym(z, f)
