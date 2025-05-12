# Functions

## Heaviside and Indicator Functions

```@docs
approx_heaviside
```


```@example
using SmoothApproximations, PlotlyLight  # hide
x = range(-2, 2, 200)  # hide
data = [  # hide
    (Config(; x, y=approx_heaviside(; k).(x), name="k=$k") for k in [1, 5, 10, 20])...,  # hide
    Config(x=[-10,0], y=[0, 0], name="original: (x < 0)", legendgroup="1", mode="lines", line=(; color="white")),  # hide
    # Config(x=[0], y=[1/2], legendgroup="1", showlegend=false, mode="markers", marker=(;size=10, color="white")),  # hide
    Config(x=[0,10], y=[1, 1], legendgroup="1", showlegend=false, mode="lines", line=(; color="white")),  # hide
]  # hide
p = Plot(data)  # hide
p.layout.title.text = "(x < 0) ≈ approx_heaviside(; k=k)(x)"  # hide
p.layout.xaxis.range=extrema(x)  # hide
p.layout.yaxis.range=(0, 1)  # hide
p  # hide
```

## Maximum and Minimum

```@docs
majorize_min
majorize_max
```

```@example
using SmoothApproximations, PlotlyLight  # hide
x = range(-2, 2, 200)  # hide
y = max.(x, 1)  # hide
data = [  # hide
    Config(; x, y, name="original: max(x, 1)", line=(;color="white"))  # hide
    [Config(; x, y=majorize_max(identity, 1; k).(x), name="majorize_max(identity, 1; k=$k)") for k in [1, 5, 10, 20]]...  # hide
]  # hide
p = Plot(data)  # hide
p.layout.title.text = "max(x, 1) ≈ majorize_max(identity, 1; k=k)(x)"  # hide
p.layout.yaxis.range=(0, 2.5)  # hide
p  # hide
```


```@example
using SmoothApproximations, PlotlyLight  # hide
x = range(-2, 2, 200)  # hide
y = max.(abs2.(x), 1)  # hide
data = [  # hide
    [Config(; x, y=majorize_max(abs2, 1; k).(x), name="majorize_max(abs2, 1; k=$k)") for k in [1, 5, 10, 20]]...  # hide
    Config(; x, y, name="original: max(abs2(x), 1)", line=(;color="white"))  # hide
]  # hide
p = Plot(data)  # hide
p.layout.title.text = "max(abs2(x), 1) ≈ majorize_max(abs2, 1; k=k)(x)"  # hide
p.layout.yaxis.range=(0, 2.5)  # hide
p  # hide
```
