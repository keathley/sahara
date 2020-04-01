defmodule Mix.Tasks.Catalog.SampleData do
  @moduledoc """
  Generates data for doing local development.
  """

  use Mix.Task

  @shortdoc "Populates the db with sample data for development"
  def run(_) do
    Application.ensure_all_started(:catalog)

    items = [
      "hat",
      "shoes",
      "t-shirt",
      "jeans",
      "skirt",
      "hoodie",
      "shorts",
      "dress",
    ]

    for item <- items do
      Catalog.Items.create_item(%{name: item, description: Weirding.words()})
    end
  end
end
