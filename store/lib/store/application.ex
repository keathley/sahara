defmodule Store.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      StoreWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Store.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    StoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
