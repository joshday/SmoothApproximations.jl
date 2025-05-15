```@setup examples
using SmoothApproximations, PlotlyLight
x = range(-2, 2, 200)

function example(x, original::Pair, approximations::Pair...; title="")
    data = [
        (Config(; x, y=approx[2], name=approx[1], line=(;width=1)) for approx in approximations)...,
        Config(; x, y=original[2], name=original[1], legendrank=1, line=(; color="white"))
    ]
    p = Plot(data)
    p.layout.title.text = title
    p.layout.title.font.family = "monospace"
    p
end
```

# Examples

## Approximate [Heaviside Function](https://en.wikipedia.org/wiki/Heaviside_step_function)

```@example examples
f = x -> float(x > 0)  # hide
example(x, "x -> (x > 0)" => f.(x), ("k=$k" => approx_step(; k).(x) for k in [1, 5, 10])...; title="x -> (x > 0) ≈ approx_step(; k=k)")  # hide
```

## Approximate If-Else

```@example examples
f = x -> x > 1 ? 2 : 5  # hide
example(x, "x -> (x > 1 ? 5 : 2)" => f.(x), ("k=$k" => approx_step(; k, at=1, from=5, to=2).(x) for k in [1, 5, 10])...; title="x -> (x > 1 ? 5 : 2) ≈ approx_step(; k, at=1, from=5, to=2)")  # hide
```

## Majorize If-Else

```@example examples
f = x -> x > 0.5 ? 1 : -1  # hide
example(x, "x -> (x > 0.5 ? 1 : -1)" => f.(x), ("k=$k" => majorize_step_up(; k, at=0.5, from=-1, to=1).(x) for k in [1, 5, 10])...; title="x -> (x > 0.5 ? 1 : -1) ≈ majorize_step_up(; k, at=0.5, from=-1, to=1)")  # hide
```

```@example examples
f = x -> x > 0.5 ? -1 : 1  # hide
example(x, "x -> (x > 0.5 ? -1 : 1)" => f.(x), ("k=$k" => majorize_step_down(; k, at=0.5, from=1, to=-1).(x) for k in [1, 5, 10])...; title="x -> (x > 0.5 ? -1 : 1) ≈ majorize_step_down(; k, at=0.5, from=1, to=-1)")  # hide
```

## Majorize Max

```@example examples
f = x -> max(x, 1)  # hide
example(x, "x -> max(x, 1)" => f.(x), ("k=$k" => majorize_max(identity, 1; k).(x) for k in [1,5,10])...; title="x -> max(x, 1) ≈ majorize_max(identity, 1; k)")  # hide
```

```@example examples
f = x -> max(x ^ 2, 1)  # hide
example(x, "x -> max(x ^ 2, 1)" => f.(x), ("k=$k" => majorize_max(x -> x^2, 1; k).(x) for k in [1,5,10])...; title="x -> max(x^2, 1) ≈ majorize_max(x -> x^2, 1; k)")  # hide
```

!!! note
    In order for the approximation to be smooth, `majorize_max(f)` requires `f` to be a smooth function.

## Minorize Max

```@example examples
f = x -> max(x, 1)  # hide
example(x, "x -> max(x, 1)" => f.(x), ("k=$k" => minorize_max(identity, 1; k).(x) for k in [1,5,10])...; title="x -> max(x, 1) ≈ minorize_max(identity, 1; k)")  # hide
```

```@example examples
f = x -> max(x ^ 2, 1)  # hide
example(x, "x -> max(x ^ 2, 1)" => f.(x), ("k=$k" => minorize_max(x -> x^2, 1; k).(x) for k in [1,5,10])...; title="x -> max(x^2, 1) ≈ minorize_max(x -> x^2, 1; k)")  # hide
```

## Minorize Min

```@example examples
f = x -> min(x, 1)  # hide
example(x, "x -> min(x, 1)" => f.(x), ("k=$k" => minorize_min(identity, 1; k).(x) for k in [1,5,10])...; title="x -> min(x, 1) ≈ minorize_min(identity, 1; k)")   # hide
```

```@example examples
f = x -> min(x ^ 2, 1)  # hide
example(x, "x -> min(x ^ 2, 1)" => f.(x), ("k=$k" => minorize_min(x -> x^2, 1; k).(x) for k in [1,5,10])...; title="x -> min(x^2, 1) ≈ minorize_min(x -> x^2, 1; k)")  # hide
```

## Majorize Min

```@example examples
f = x -> min(x, 1)  # hide
example(x, "x -> min(x, 1)" => f.(x), ("k=$k" => majorize_min(identity, 1; k).(x) for k in [1,5,10])...; title="x -> min(x, 1) ≈ majorize_min(identity, 1; k)")   # hide
```

```@example examples
f = x -> min(x ^ 2, 1)  # hide
example(x, "x -> min(x ^ 2, 1)" => f.(x), ("k=$k" => majorize_min(x -> x^2, 1; k).(x) for k in [1,5,10])...; title="x -> min(x^2, 1) ≈ majorize_min(x -> x^2, 1; k)")  # hide
```
