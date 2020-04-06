defmodule Catalog.CatalogHandler do

  alias Catalog.Items

  def get_items(_ctx, _req) do
    items = for item <- Items.list_items() do
      Sahara.Catalog.Item.new(
        id: item.id,
        name: item.name,
        description: item.description
      )
    end

    Sahara.Catalog.ItemsResp.new(items: items)
  end

  def get_item(_ctx, req) do
    item = Items.get_item!(req.id)

    Sahara.Catalog.Item.new(
      id: item.id,
      name: item.name,
      description: item.description
    )
  end
end
