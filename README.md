# Numerical exponential polynomials

Projects related to efficient numerical and analytic study of exponential polynomials in julia.

## Numerical locus of zeros of exponential polynomials

1. Use argument principal to find the zeros of a given exponential polynomial in a given rectangular region. Assume only simple zeros.
2. Allow higher order zeros; terminating criteria.
3. Different shaped regions.
4. Improved algorithms inspired by the paper Fedi was reading.
5. Parallelize

## Asymptotic locus of zeros of exponential polynomials

1. Automatically find the asymptotic locus of zeros of a given exponential sum.
2. As 1 but with an exponential polynomial.
3. Higher order approximation.
4. Explicit error bounds.
5. Arbitrary order approximation.

## Analytical-geometric asymptotic analysis of exponential polynomials

1. Along a given ray in the plane, determine the term(s) with leading order contribution.
2. In a given region, determine the term(s) with most significant contribution.
3. Find the curves / rays on which the contributions of different terms become significant / dominant.
4. Find an appropriate partition of the plane into regions and the terms of interest in each region.

## Evaluation of oscillatory integrals of ratios of exponential polynomials (requires some progress on other projects first)

1. Design a data structure for ratios of exponential polynomials; the integrands that appear in UTM solution formulae.
2. Construct changes of variables to map ray, segment and circular arc contours (and their concatenations) to real intervals, and implement the corresponding changes of variables in ratios of exponential polynomials.
3. Use ApproxFun or another appropriate package to evaluate the integrals at a given (x,t).
4. Parallelize the process so that plots can be efficiently produced for a broad range of (x,t).
