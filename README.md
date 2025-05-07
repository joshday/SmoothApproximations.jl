# SmoothApproximations

[![Build Status](https://github.com/joshday/SmoothApproximations.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/joshday/SmoothApproximations.jl/actions/workflows/CI.yml?query=branch%3Amain)

This package provides a collection of function closures for creating smooth approximations of discontinuous functions.

# Usage

```julia
using SmoothApproximations
using Plots

f = SmoothApproximations.approx_heaviside

plot(f(k=1), label = "k=1")
plot!(f(k=5), label = "k=5")
plot!(f(k=20), label = "k=20")
plot!(f(k=50), label = "k=50")
```
