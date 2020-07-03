include("ExpSum.jl")
include("operators_expsum.jl")

using LazySets

function getPolyCoords(x::ExpSum)
    conjList = Array[]
    for i in x.ExpList
        re = real(i)
        im = -1 * imag(i)
        push!(conjList, [re,im])
    end
    # this specific type is for the convex_hull function in the package LazySets
    return convert(Array{Array{Float64,1},1}, conjList)
end


#= a = ExpSum(Complex{Float64}[1.0 + 0.0im, 2.0 + 1.0im, 3.0 + 0.0im], Complex{Float64}[2.45 + 0.0im, 5.0 + 1.0im, 7.01 + 0.0im])
c = getPolyCoords(a)
hull = convex_hull(c) =#