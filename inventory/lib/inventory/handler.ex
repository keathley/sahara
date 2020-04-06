defmodule Inventory.Handler do
  def get_count(_ctx, %{id: id}) do
    count = Inventory.Counts.in_stock_count(id)
    Sahara.Inventory.Count.new(in_stock: count)
  end
end
