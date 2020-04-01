defmodule InventoryTest do
  use ExUnit.Case

  setup_all do
    config = Inventory.Application.config!()

    {:ok, url: "http://localhost:#{config.port}"}
  end

  test "returns the current count or 0 if not found", %{url: url} do
    id = UUID.uuid4()
    {:ok, resp} = Mojito.get("#{url}/counts/#{id}/in_stock")
    resp = Jason.decode!(resp.body)

    assert resp["count"] == 0
  end

  test "can add or subtract counts", %{url: url} do
    id = UUID.uuid4()
    Mojito.post("#{url}/counts/#{id}/inc")
    Mojito.post("#{url}/counts/#{id}/inc")
    {:ok, resp} = Mojito.post("#{url}/counts/#{id}/inc")
    resp = Jason.decode!(resp.body)
    assert resp["count"] == 3

    Mojito.post("#{url}/counts/#{id}/dec")
    {:ok, resp} = Mojito.post("#{url}/counts/#{id}/dec")
    resp = Jason.decode!(resp.body)
    assert resp["count"] == 1
  end
end
