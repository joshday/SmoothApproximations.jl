# Introduction

- **SmoothApproximations** provides smooth (infinitely differentiable) approximations to common function that have discontinuities.

!!! note
    Functions provided in SmoothApproximations return another function, e.g.
    ```julia
        using SmoothApproximations

        f = majorize_min(identity, 1; k=15)

        f(0.7)
    ```

## Kinds of Approximations

This package contains three kinds of function approximations, denoted with a prefix:

1. `approx_`
2. `majorize_`
3. `minorize_`

### Approximation (`approx_`)

- Functions that begin with `approx_` have no guarantees other than infinite differentiability.
- Depending on the input, the approximation may evaluate to a value either smaller or larger than that of the original function.

### Majorization (`majorize_`)

- A function ``g(x)`` is said to *majorize* ``f(x)`` over domain ``D`` if ``f(x) ≤ g(x)`` for all ``x`` in ``D``.
- In other words, `majorize_` functions are guaranteed to be *larger than or equal* to the original function.

### Minorization (`minorize_`)

- A function ``g(x)`` is said to *minorize* ``f(x))`` over domain ``D`` if ``f(x) ≥ g(x)`` for all ``x`` in ``D``.
- In other words, `minorize_` functions are guaranteed to be *smaller than or equal to* the original function.
