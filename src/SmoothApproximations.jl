module SmoothApproximations

abstract type SmoothTransition end

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
approx_heaviside(; from=0, to=1, at=0, k=50) = x -> (to - from) * tanh(k * (x - at)) / 2 + (from + to) / 2


#-----------------------------------------------------------------------------# approx_min
_approx_min(x::Number, y::Number; k=10) = (exp(-k * x) + exp(-k * y)) / (exp(x) + exp(y))

"""
    majorize_min(f, val; k=10)

Smooth majorization of `x -> minimum(f(x), val)`.
"""
majorize_min(f, val; k=10) = x -> _approx_min(f(x), val; k)

majorize_max(f, val; k=10) = x -> val + log1p(exp(k * x)) / k

#-----------------------------------------------------------------------------# utils


end
