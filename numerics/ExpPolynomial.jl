include("ExpSum.jl")
using SymPy

struct ExpPolynomial
    ExpList::Array{ComplexF64}
    PolyList::Array{Polynomial} 
end

function ExpPolyConvert(x::ExpPolynomial)
    
    ExpList = x.ExpList
    PolyList = x.PolyList
    
    if(length(ExpList) != length(PolyList))
        error("Invalid Exponential Polynomial")
    end

    CheckList = Dict{ComplexF64, Int64}()
    
    for i = 1:length(ExpList)
        if haskey(CheckList, ExpList[i])
            #if the same exponent already exists, add polynomial to the term where it first appears
            
            PolyList[CheckList[ExpList[i]]] += PolyList[i]
            PolyList[i] = 0
            
            #the next if-statement will later ignore this term
        else
            #create a new entry in the dictionary
            CheckList[ExpList[i]] = i
        end
    end
                
    newExpList = ComplexF64[]
    #empty list to store new ExpList values
    newPolyList = Polynomial[]
    #empty list to store new PolyList values 
        
    for i = 1:length(PolyList)
        #make sure CoeffList has no zero
        if(PolyList[i] != 0)
            push!(newPolyList, PolyList[i])
            append!(newExpList, ExpList[i])
        end
    end
        
    return (ExpPolynomial(newExpList, newPolyList))   
        
end

# Evaluate exponential polynomial

function expPoly(z::Number, x::ExpPolynomial)
        
    z = convert(ComplexF64, z)
    
    expList = deepcopy(x.ExpList)
    for i = 1:length(expList)
        expList[i] *= z
    end
    
    coeffList = ComplexF64[]
    for j = 1:length(x.PolyList)
        temp = x.PolyList[j]
        append!(coeffList, temp(z))
    end
    
    ExpPolyConvert(expList, coeffList)
    
end

(f::ExpPolynomial)(z::Number) = expPoly(z, f)

# SymPy version

function expPolySym(z::Sym, x::ExpPolynomial)
    
    coeffList = []
    for j = 1:length(x.PolyList)
        pol = 0
        for k = 1:length(x.PolyList[j])
            pol += x.PolyList[j][k-1] * z^(k-1)
        end
        append!(coeffList, pol)
    end
    
    symList = 0
    for i = 1:length(x.ExpList)
        symList += coeffList[i] * exp(x.ExpList[i] * z)
    end
    
    return symList
    
end
