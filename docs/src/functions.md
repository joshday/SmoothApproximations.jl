# Functions

## Heaviside and Indicator Functions

```@docs
approx_heaviside
```


```@example
using SmoothApproximations, PlotlyLight
x = range(-2, 2, 200)
data = [
    (Config(; x, y=approx_heaviside(; k).(x), name="k=$k") for k in [1, 5, 10, 20])...,
    Config(x=[-10,0], y=[0, 0], name="original", legendgroup="1", mode="lines", line=(; color="white")),
    Config(x=[0], y=[1/2], legendgroup="1", showlegend=false, mode="markers", marker=(;size=10, color="white")),
    Config(x=[0,10], y=[1, 1], legendgroup="1", showlegend=false, mode="lines", line=(; color="white")),
]
p = Plot(data)
p.layout.title.text = "approx_heaviside(; k=k)"
p.layout.xaxis.range=extrema(x)
p.layout.yaxis.range=(0, 1)
p
```
