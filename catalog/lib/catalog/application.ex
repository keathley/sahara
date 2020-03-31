defmodule Catalog.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Catalog.Repo,
      CatalogWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Catalog.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    CatalogWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
