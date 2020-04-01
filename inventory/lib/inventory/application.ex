defmodule Inventory.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    config = config!()

    children = [
      {Inventory.Counts, [database: config.redis_db]},
      {Plug.Cowboy, scheme: :http, plug: Inventory.Router, options: [port: config.port]},
    ]

    opts = [strategy: :one_for_one, name: Inventory.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config! do
    Vapor.load!([
      %Vapor.Provider.Dotenv{},
      %Vapor.Provider.Env{
        bindings: [
          {:port, "WEB_PORT", map: &String.to_integer/1},
          {:redis_db, "REDIS_DB", map: &String.to_integer/1},
        ]
      }
    ])
  end
end
