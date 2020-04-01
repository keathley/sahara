defmodule CatalogWeb.Router do
  use CatalogWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CatalogWeb do
    pipe_through :api

    resources "/items", ItemController, except: [:new, :edit]
  end
end
