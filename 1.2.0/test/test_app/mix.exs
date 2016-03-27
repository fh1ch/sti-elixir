defmodule TestApp.Mixfile do
  use Mix.Project

  def project do
    [app: :test_app,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :cowboy, :timex],
     mod: {TestApp, []}]
  end

  defp deps do
    [{:cowboy, "~> 1.0.0"},
     {:timex, "~> 2.1.1"}]
  end
end
