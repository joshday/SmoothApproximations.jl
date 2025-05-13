module SmoothApproximations

export approx_heaviside, majorize_min, minorize_min, majorize_max, minorize_max

#-----------------------------------------------------------------------------# approx_heaviside
"""
    approx_heaviside(; from=0, to=1, at=0, k=50)

Approximate the heaviside step function, generalized to any step size (`from` and `to`) and
location (`at`), using a hyperbolic tangent function with steepness parameter `k`.

- Heaviside:
| x < at | x == at | x > at |
|:-------:|:--------:|:------:|
| ``from`` | ``(to-from) / 2`` | ``to`` |

- Approximate Heaviside:
```math
(to - from) * tanh(k * (x - at)) / 2 + (from + to) / 2
```
"""
approx_heaviside(; from=0, to=1, at=0, k=10) = x -> (to - from) * tanh(k * (x - at)) / 2 + (from + to) / 2


#-----------------------------------------------------------------------------# min/max utils

# softplus-ish
_majorize_max(x, y; k=10) = y + log1p(exp(k * (x - y))) / k

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
