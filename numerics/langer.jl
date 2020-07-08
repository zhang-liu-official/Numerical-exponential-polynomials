include("ExpSum.jl")
include("operators_expsum.jl")

using LazySets, Polynomials

function getConjDict(x::ExpSum)
    #=
    Input: object of type Exponential Sum
    Output: dictionary with terms from the input as values, and conjugate coordinates as corresponding keys
    =#

    conjDict = Dict{Array{Float64,1}, ExpSum}()
    for i in 1:length(x.ExpList)
        term = x.ExpList[i]
        re = real(term)
        im = -1 * imag(term)
        conjDict[[re,im]] = ExpSum([term], [x.CoeffList[i]])
    end
    return conjDict
end

function getConvexHull(d::Dict{Array{Float64,1}, ExpSum})
    conjList = collect(keys(d))
    return convex_hull(conjList)
end

struct Locus
    alpha::Number
    roots::Array{Number,1}
end

function getPolyExp(x::Array{Float64,1}, y::Array{Float64,1}, d::Dict{Array{Float64,1}, ExpSum})
    #= Input: 2 coordinates that form a side of the polygon
    Output: 2 corresponding terms of type ExpSum, in polynomial expression =#
    t1 = d[x]
    t2 = d[y]

    e1 = t1.ExpList[1]
    c1 = t1.CoeffList[1]
    e2 = t2.ExpList[1]
    c2 = t2.CoeffList[1]

    if (e1 == 0)
        r = Polynomials.roots(Polynomial([c1, c2]))
        alpha = e2

    elseif (e2 == 0)
        r = Polynomials.roots(Polynomial([c2, c1]))
        alpha = e1

    else
        r = Polynomials.roots(Polynomial([c1, c2]))
        alpha = c2 - c1  
    end

    return Locus(alpha, r)
end


# Testing

a = ExpSum(Complex{Float64}[1.0 + 0.0im, 2.0 + 1.0im, 3.0 + 0.0im, 2.0 + 0.0im], Complex{Float64}[2.45 + 0.0im, 5.0 + 1.0im, 7.01 + 0.0im, 7.01 + 0.0im])
dic = getConjDict(a)
h = getConvexHull(dic)
getPolyExp([2.0, -1.0], [3.0, -0.0], dic)





# using QHull
# using Polyhedra

# new_c= vcat(c'...)



# function getPolyCoords(x::Array{Array{Float64,1},1})
#     hull = convex_hull(x)
#     for i in 1:length(x) 
#         for j in 1:length(hull)

#         end
#     end
# end


# p = rand(10,2)
# ch = chull(p)
# ch.points         # original points
# ch.vertices       # indices to line segments forming the convex hull
# ch.simplices      # the simplexes forming the convex hull
# show(ch)

# chull(new_c)
# p |> typeof




