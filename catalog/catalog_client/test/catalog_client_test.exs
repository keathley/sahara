defmodule CatalogClientTest do
  use ExUnit.Case
  doctest CatalogClient

  test "greets the world" do
    assert CatalogClient.hello() == :world
  end
end
