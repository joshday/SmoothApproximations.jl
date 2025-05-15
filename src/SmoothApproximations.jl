module SmoothApproximations

export
    approx_step, majorize_step_up, majorize_step_down,
    majorize_min, minorize_min,
    majorize_max, minorize_max

#-----------------------------------------------------------------------------# approx_step
"""
    approx_step(; from=0, to=1, at=0, k=10)

Approximate a step function that makes the jump `from` --> `to` at point `at`.
The approximation uses a hyperbolic tangent function with steepness parameter `k`.
"""
approx_step(; from=0, to=1, at=0, k=10) = x -> (to - from) * tanh(k * (x - at)) / 2 + (from + to) / 2


"""
    majorize_step_up(; from=0, to=1, at=0, k=10)

Majorize a step function that makes the jump `from` --> `to` at point `at`.
The majorization uses a hyperbolic tangent function with steepness parameter `k`.  It's equivalent to
`approx_step` with a shifted `to` parameter to ensure majorization.
"""
function majorize_step_up(; from=0, to=1, at=0, k=10)
    to′ = to + 1 / k
    at′ = at - 1 / k
    f = approx_step(; from, to=to′, at = at′, k)
    ϵ = to - f(at)
    return approx_step(; from, to = to′ + ϵ, at = at′, k)
end

"""
    majorize_step_up(; from=0, to=1, at=0, k=10)

Majorize a step function that makes the jump `from` --> `to` at point `at`.
The majorization uses a hyperbolic tangent function with steepness parameter `k`.  It's equivalent to
`approx_step` with a shifted `to` parameter to ensure majorization.
"""
function majorize_step_down(; from=0, to=1, at=0, k=10)
    from′ = from + 1 / k
    at′ = at + 1 / k
    f = approx_step(; from = from′, to, at = at′, k)
    ϵ = from - f(at)
    return approx_step(; from = from′ + ϵ, to, at = at′, k)
end


#-----------------------------------------------------------------------------# utils
_majorize_max(x, y; k=10) = y + log1p(exp(k * (x - y))) / k  # softplus-ish

_minorize_min(x, y; k=10) = -_majorize_max(-x, -y; k)

function _majorize_min(x, y; k=10)
    ex = exp(-k * x)
    ey = exp(-k * y)
    return (x * ex + y * ey) / (ex + ey)
end

_minorize_max(x, y; k=10) = -_majorize_min(-x, -y; k)




#-----------------------------------------------------------------------------# majorize_min
"""
    majorize_min(f, val; k=10)

Smooth *majorization* of `x -> min(f(x), val)` where `f` is a smooth function and `val` is a constant.
"""
majorize_min(f, val; k=10) = x -> _majorize_min(f(x), val; k)

#-----------------------------------------------------------------------------# minorize_min
"""
    minorize_min(f, val; k=10)

Smooth *minorization* of `x -> min(f(x), val)` where `f` is a smooth function and `val` is a constant.
"""
minorize_min(f, val; k=10) = x -> _minorize_min(f(x), val; k)  #-_majorize_max(-f(x), -val; k)

#-----------------------------------------------------------------------------# majorize_max
"""
    majorize_max(f, val; k=10)

Smooth majorization of `x -> max(f(x), val)` where `f` is a smooth function and `val` is a constant.
"""
majorize_max(f, val; k=10) = x -> _majorize_max(f(x), val; k)

#-----------------------------------------------------------------------------# minorize_max
"""
    minorize_max(f, val; k=10)

Smooth minorization of `x -> max(f(x), val)` where `f` is a smooth function and `val` is a constant.
"""
minorize_max(f, val; k=10) = x -> _minorize_max(f(x), val; k)

end
