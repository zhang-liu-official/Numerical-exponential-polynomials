include("ExpPolynomial.jl")

function Base.:+(x::ExpPolynomial, y::ExpPolynomial)
    
    newExpList = deepcopy(x.ExpList)
    newPolyList = deepcopy(x.PolyList)
    
    for i = 1:length(y.ExpList)
        append!(newExpList, y.ExpList[i])
        push!(newPolyList, y.PolyList[i])
    end
    
    ExpPolyConvert(ExpPolynomial(newExpList, newPolyList))
        
end

function Base.:-(x::ExpPolynomial, y::ExpPolynomial)
    
    newExpList = deepcopy(x.ExpList)
    newPolyList = deepcopy(x.PolyList)
    
    for i = 1:length(y.ExpList)
        append!(newExpList, y.ExpList[i])
        push!(newPolyList, -1 * y.PolyList[i])
    end
    
    ExpPolyConvert(ExpPolynomial(newExpList, newPolyList))
        
end

function Base.:*(x::ExpPolynomial, y::Number)
    
    y = convert(ComplexF64, y)    
    newPolyList = Polynomial[]
    
    for i = 1:length(x.PolyList)
        push!(newPolyList, y * x.PolyList[i])
    end
    
    ExpPolyConvert(ExpPolynomial(x.ExpList, newPolyList))
        
end

function Base.:*(y::Number, x::ExpPolynomial)
    
    y = convert(ComplexF64, y)
    return (x * y)
        
end

function Base.:*(x::ExpPolynomial, y::ExpPolynomial)
    
    newExpList = ComplexF64[]
    newPolyList = Polynomial[]
     
    for i = 1:length(x.ExpList)
        for j = 1:length(y.ExpList)
            append!(newExpList, x.ExpList[i] + y.ExpList[j])
            push!(newPolyList, x.PolyList[i] * y.PolyList[j])
        end
    end
    
    ExpPolyConvert(ExpPolynomial(newExpList, newPolyList))
    
end