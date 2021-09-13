defmodule ShopWeb.Router do
  use ShopWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ShopWeb do
    pipe_through :api
  end
end
