defmodule Inventory.MixProject do
  use Mix.Project

  def project do
    [
      app: :inventory,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Inventory.Application, []}
    ]
  end

  defp deps do
    [
      {:redix, "~> 0.10"},
      {:plug_cowboy, "~> 2.1"},
      {:jason, "~> 1.2"},
      {:mojito, "~> 0.6"},
      {:uuid, "~> 1.1"},
      {:vapor, "~> 0.7"},

      {:inventory_client, path: "inventory_client"},
    ]
  end
end
