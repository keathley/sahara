defmodule Inventory.Counts do
  def child_spec(opts \\ []) do
    redix_opts = Keyword.put(opts, :name, __MODULE__)

    %{
      id: __MODULE__,
      start: {Redix, :start_link, [redix_opts]},
    }
  end

  def inc(id) do
    Redix.command!(__MODULE__, ["INCR", count_key(id)])
  end

  def dec(id) do
    Redix.command!(__MODULE__, ["DECR", count_key(id)])
  end

  def in_stock_count(id) do
    case Redix.command!(__MODULE__, ["GET", count_key(id)]) do
      nil -> 0
      count when is_binary(count) -> String.to_integer(count)
    end
  end

  defp count_key(id) do
    "inventory:count:#{id}"
  end
end
