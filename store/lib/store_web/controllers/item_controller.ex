defmodule StoreWeb.ItemController do
  use StoreWeb, :controller

  alias Sahara.Inventory.InventoryClient
  alias Sahara.Catalog.CatalogClient

  def index(conn, _params) do
    with {:ok, resp} <- get_items() do
      render(conn, "index.html", items: resp.items)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, item} <- get_item(id),
         {:ok, counts} <- get_inventory(id) do
      render(conn, "show.html", item: item, count: counts.in_stock)
    end
  end

  defp get_items do
    client = CatalogClient.new(:proto, "http://localhost:4010")
    CatalogClient.get_items(client, Sahara.Catalog.ItemsReq.new())
    # with {:ok, resp} <- Mojito.get("http://localhost:4010/api/items"),
    #      {:ok, json} <- Jason.decode(resp.body) do
    #   items =
    #     json["data"]
    #     |> Enum.map(fn item -> %{id: item["id"], name: item["name"]} end)

    #   {:ok, items}
    # end
  end

  defp get_item(id) do
    client = CatalogClient.new(:proto, "http://localhost:4010")
    CatalogClient.get_item(client, Sahara.Catalog.ItemReq.new(id: id))
  end

  defp get_inventory(id) do
    client = InventoryClient.new(:proto, "http://localhost:4020/")
    InventoryClient.get_count(client, %Sahara.Inventory.Item{id: id})
  end
end
