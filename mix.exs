defmodule Medor.Mixfile do
  use Mix.Project

  def project do
    [app: :medor,
     version: "0.3.0",
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
      {:phoenix , "0.10.0"},
      {:plug, ">= 0.10.0"},
      {:cowboy, "~> 1.0"},
      {:joken, "0.11.0"},
      {:timex, "~> 0.13.3"},
      {:inflex, "~> 1.0.0"}
    ]
  end
end
