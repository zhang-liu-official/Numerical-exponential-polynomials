include("langer.jl")

using Plots

function getShape(x::ExpSum)
    xs = []
    ys = []

    for i in 1:length(x.ExpList)
        term = x.ExpList[i]
        re = real(term)
        im = -1 * imag(term)
        append!(x, re)
        append!(y, im)
    end

    return Shape(xs, ys)
end

function getPolyPlot(x::ExpSum)
    s = getShape(x)
    plot(s, opacity=0.5, aspect_ratio=:equal)
end

#= 
Plan: 
Get the equations of each side
Get the center point of each side? Question: does the locus come from the center point? 
Then plot the normal of each side, passing through the center point =#