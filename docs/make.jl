push!(LOAD_PATH, joinpath(@__DIR__, "..", "src"))

using Documenter, PlotlyLight, SmoothApproximations

PlotlyLight.preset.template.plotly_dark!()

makedocs(
    sitename = "SmoothApproximations.jl",
)
