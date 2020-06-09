using SymPy

struct ExpSum
    ExpList::Array{ComplexF64}
    CoeffList::Array{ComplexF64}
end

function ExpPolyConvert(ExpList::Array{ComplexF64}, CoeffList::Array{ComplexF64})
    if (length(ExpList) != length(CoeffList))
        error("Invalid Exponential Polynomial")
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

# Operators 

function Base.:+(x::ExpSum, y::ExpSum)
    
    # deepcopy avoids changing the ExpList of x     
    newExpList = deepcopy(x.ExpList)
    newCoeffList = deepcopy(x.CoeffList)
    
    for i = 1:length(y.ExpList)
        append!(newExpList, y.ExpList[i])
        append!(newCoeffList, y.CoeffList[i])
    end
    
    ExpPolyConvert(newExpList, newCoeffList)
        
end

function Base.:-(x::ExpSum, y::ExpSum)
    
    newExpList = deepcopy(x.ExpList)
    newCoeffList = deepcopy(x.CoeffList) 
    
    for i = 1:length(y.ExpList)
        append!(newExpList, y.ExpList[i])
        append!(newCoeffList, -1.0 * y.CoeffList[i])
    end
    
    ExpPolyConvert(newExpList, newCoeffList)
           
end

function Base.:*(x::ExpSum, y::Number)
    
    y = convert(ComplexF64, y)
    newCoeffList = ComplexF64[]
    
    for i = 1:length(x.CoeffList)
        append!(newCoeffList, x.CoeffList[i] * y)
    end
    
    return (ExpSum(x.ExpList, newCoeffList))
        
end

function Base.:*(y::Number, x::ExpSum)
    
    y = convert(ComplexF64, y)
    return (x * y)
        
end

function Base.:*(x::ExpSum, y::ExpSum)
    
    newExpList = ComplexF64[]
    # empty list to store new ExpList values
    newCoeffList = ComplexF64[]
    # empty list to store new CoeffList values 
     
    for i = 1:length(x.ExpList)
        for j = 1:length(y.ExpList)
            append!(newExpList, x.ExpList[i] + y.ExpList[j])
            append!(newCoeffList, x.CoeffList[i] * y.CoeffList[j])
        end
    end
    
    ExpPolyConvert(newExpList, newCoeffList)
    
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

struct ExpPolynomial
    ExpList::Array{ComplexF64}
    PolyList::Array{Tuple}
end

function expPoly(z::Number, x::ExpPolynomial)
        
    z = convert(ComplexF64, z)
    
    expList = deepcopy(x.ExpList)
    for i = 1:length(expList)
        expList[i] *= z
    end
    
    coeffList = ComplexF64[]
    for j = 1:length(x.PolyList)
        temp = evalpoly(z, x.PolyList[j])
        append!(coeffList, temp)
    end
    
    ExpPolyConvert(expList, coeffList)
    
end

(f::ExpPolynomial)(z::Number) = expPoly(z, f)

function expPolySym(z::Sym, x::ExpPolynomial)
    
    coeffList = []
    for j = 1:length(x.PolyList)
        pol = 0
        for k = 1:length(x.PolyList[j])
            pol += x.PolyList[j][k] * z^(k - 1)
        end
        append!(coeffList, pol)
    end
    
    symList = 0
    for i = 1:length(x.ExpList)
        symList += coeffList[i] * exp(x.ExpList[i] * z)
    end
    
    return symList
    
end