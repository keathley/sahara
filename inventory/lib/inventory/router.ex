defmodule Inventory.Router do
  use Plug.Router

  import Plug.Conn

  plug Plug.Parsers, parsers: [:urlencoded, :json],
    pass: ["*/*"],
    json_decoder: Jason

  plug :match
  plug :dispatch

  post "/counts/:id/inc" do
    count = Inventory.Counts.inc(id)

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(201, Jason.encode!(%{result: "ok", count: count}))
  end

  post "/counts/:id/dec" do
    count = Inventory.Counts.dec(id)

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(201, Jason.encode!(%{result: "ok", count: count}))
  end

  get "/counts/:id/in_stock" do
    count = Inventory.Counts.in_stock_count(id)

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, Jason.encode!(%{count: count}))
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
