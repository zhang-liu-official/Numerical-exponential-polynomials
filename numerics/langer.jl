include("ExpSum.jl")
include("operators_expsum.jl")

using LazySets, Polynomials

# Types   
# Convex Hull: Array{Array{Array{Float64,1}
# Side: Array{Array{Float64,1}, 1}
# Point: Array{Float64,1}

function getConjDict(x::ExpSum)
    """
    Input: object of type Exponential Sum
    Output: dictionary with terms from the input as values, and conjugate coordinates as corresponding keys
    """

    conjDict = Dict{Array{Float64,1}, ExpSum}()
    for i in 1:length(x.ExpList)
        term = x.ExpList[i]
        re = real(term)
        im = -1 * imag(term)
        conjDict[[re,im]] = ExpSum([term], [x.CoeffList[i]])
    end
    return conjDict
end

function isPointOnLine(a::Array{Float64,1}, b::Array{Float64,1}, f::Array{Float64,1})
    """
    Input: 3 coordinates
    Output: true if 3rd point is on line formed by first 2 points, false otherwise
    """
    m = (b[2]-a[2])/(b[1]-a[1])
    c = a[2] - m * a[1]
    if (f[2] == m * f[1] + c)
        return true
    else 
        return false
    end
end

function getConvexHull(d::Dict{Array{Float64,1}, ExpSum})
    """
    Input: conjDict from getConjDict
    Output: Sides of the convex hull
    """
    conjList = collect(keys(d))
    h = convex_hull(conjList)

    # Sides of the convex hull
    sidesList = Array{Array{Float64,1}, 1}[]
    i = 1
    while i < length(h)
        push!(sidesList, [h[i], h[i+1]])
        i += 1
    end
    push!(sidesList, [h[i], h[1]])

    # Points that are not vertices of polygon 
    unusedList = Array{Float64,1}[]
    for j in conjList
        if !(j in h) 
            push!(unusedList, j)
        end
    end

    function getSidesList(unchecked_sides, unused_points, checked_sides)
        n = length(unchecked_sides)
        m = length(unused_points)
        if (n == 0)
            return checked_sides
        elseif (m == 0)
            # add remaining unchecked_sides to checked_sides
            return vcat(unchecked_sides, checked_sides)
        else 
            new_unused_points = Array{Float64,1}[]
            for i in 1:m 
                if(isPointOnLine(unchecked_sides[1][1], unchecked_sides[1][2], unused_points[i]))
                    # modify the side
                    push!(unchecked_sides[1], unused_points[i])
                else
                    push!(new_unused_points, unused_points[i])
                end 
            end
            # the side is now checked
            push!(checked_sides, unchecked_sides[1])
            # update unchecked_sides
            popfirst!(unchecked_sides)

            # recursive call with updated arguments
            getSidesList(unchecked_sides, new_unused_points, checked_sides)
            
        end
    end

    getSidesList(sidesList, unusedList, Array{Array{Float64,1}, 1}[])

end


struct Locus
    alpha::Number
    roots::Array{Number,1}
end

function getLocus2Points(x::Array{Float64,1}, y::Array{Float64,1}, d::Dict{Array{Float64,1}, ExpSum})
    #= Input: 2 coordinates that form a side of the polygon, dictionary of coordinates and original terms
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
        alpha = e2 - e1  
    end

    return Locus(alpha, r)
end

function getLocus(x::Array{Array{Float64,1},1}, d::Dict{Array{Float64,1}, ExpSum})
    """
    Input: a side
    Output: Locus of that side
    """
    if (length(x) == 2)
        getLocus2Points(x[1], x[2], d)
    else
        eList = []
        cList = []
        for point in x
            term = d[point]
            push!(eList, term.ExpList[1])
            push!(cList, term.CoeffList[1])
            # maybe check whether is 0 or not? 
            # cases: one of the exponents is 0, check whether the others are commensurate
            # all exponents are commensurate
            # not commensurate -> collinear case 
        end

    end
end





# Testing

a = ExpSum(Complex{Float64}[1.0 + 0.0im, 2.0 + 1.0im, 3.0 + 0.0im, 2.0 + 0.0im], Complex{Float64}[2.45 + 0.0im, 5.0 + 1.0im, 7.01 + 0.0im, 7.01 + 0.0im])
dic = getConjDict(a)
h = getConvexHull(dic)
getLocus2Points([2.0, -1.0], [3.0, -0.0], dic)

# cos(3x)
b = ExpSum(Complex{Float64}[3im, -3im], Complex{Float64}[0.5,0.5])
dic_b = getConjDict(b)
h = getConvexHull(dic_b)
getLocus2Points([0.0, -3.0],  [0.0, 3.0], dic_b)
# Locus(0.0 - 6.0im, Number[-1.0 + 0.0im])




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




