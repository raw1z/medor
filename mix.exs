defmodule Medor.Mixfile do
  use Mix.Project

  def project do
    [app: :medor,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:phoenix , github: "raw1z/phoenix", branch: "dynamic-port2"},
      {:plug, ">= 0.10.0"},
      {:cowboy, "~> 1.0"},
      {:joken, "0.8.1"},
      {:timex, "~> 0.13.3"},
      {:inflex, "~> 1.0.0"}
    ]
  end
end
