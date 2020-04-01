defmodule StoreWeb.Router do
  use StoreWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StoreWeb do
    pipe_through :browser

    get "/", ItemController, :index

    resources "/items", ItemController, only: [:show]
  end
end
