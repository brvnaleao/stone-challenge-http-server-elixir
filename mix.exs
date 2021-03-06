defmodule StoneChallenge.MixProject do
  use Mix.Project

  def project do
    [
      app: :stone_challenge,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {StoneChallenge.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.11"},
      {:plug_cowboy, "~> 2.4"},
      {:jason, "~> 1.2"}
    ]
  end
end
