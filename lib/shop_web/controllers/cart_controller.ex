defmodule ShopWeb.CartController do
  use ShopWeb, :controller

  alias Shop.Shopping
  alias Shop.Shopping.Cart

  action_fallback ShopWeb.FallbackController

  def index(conn, _params) do
    carts = Shopping.list_carts()
    render(conn, "index.json", carts: carts)
  end

  def create(conn, %{"cart" => cart_params}) do
    with {:ok, %Cart{} = cart} <- Shopping.create_cart(cart_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.cart_path(conn, :show, cart))
      |> render("show.json", cart: cart)
    end
  end

  def show(conn, %{"id" => id}) do
    cart = Shopping.get_cart!(id)
    render(conn, "show.json", cart: cart)
  end
end
