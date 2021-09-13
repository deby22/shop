defmodule ShopWeb.Router do
  use ShopWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ShopWeb do
    pipe_through :api
    resources "/carts", CartController, only: [:index, :create, :show]
    resources "/coupons", CouponController, only: [:index, :create]
    get "/coupons/:uuid", CouponController, :show
  end
end
