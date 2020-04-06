defmodule InventoryClientTest do
  use ExUnit.Case
  doctest InventoryClient

  test "greets the world" do
    assert InventoryClient.hello() == :world
  end
end
