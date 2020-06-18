include("ExpSum.jl")

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