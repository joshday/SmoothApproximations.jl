push!(LOAD_PATH, joinpath(@__DIR__, "..", "src"))

using Documenter, PlotlyLight, SmoothApproximations

PlotlyLight.preset.template.plotly_dark!()

makedocs(
    sitename = "SmoothApproximations.jl",
    format=Documenter.HTML(size_threshold = 999999)
)

deploydocs(
    repo = "github.com/joshday/SmoothApproximations.jl.git",
)
