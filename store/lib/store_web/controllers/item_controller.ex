defmodule StoreWeb.ItemController do
  use StoreWeb, :controller

  alias Inventory.InventoryClient

  def index(conn, _params) do
    with {:ok, items} <- get_items() do
      render(conn, "index.html", items: items)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, item} <- get_item(id),
         {:ok, in_stock_count} <- get_inventory(id) do
      render(conn, "show.html", item: item, count: in_stock_count)
    end
  end

  defp get_items do
    with {:ok, resp} <- Mojito.get("http://localhost:4010/api/items"),
         {:ok, json} <- Jason.decode(resp.body) do
      items =
        json["data"]
        |> Enum.map(fn item -> %{id: item["id"], name: item["name"]} end)

      {:ok, items}
    end
  end

  defp get_item(id) do
    with {:ok, resp} <- Mojito.get("http://localhost:4010/api/items/#{id}"),
         {:ok, json} <- Jason.decode(resp.body) do
      item = %{
        id: get_in(json, ["data", "id"]),
        name: get_in(json, ["data", "name"]),
        description: get_in(json, ["data", "description"]),
      }
      {:ok, item}
    end
  end

  defp get_inventory(id) do
    client = InventoryClient.new("http://localhost:4020/")
    InventoryClient.get_count(client, %Sahara.Inventory.Item{id: id})
  end
end
