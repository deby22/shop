defmodule ShopWeb.CouponController do
  use ShopWeb, :controller

  alias Shop.Shopping
  alias Shop.Shopping.Coupon

  action_fallback ShopWeb.FallbackController

  def index(conn, _params) do
    coupons = Shopping.list_coupons()
    render(conn, "index.json", coupons: coupons)
  end

  def create(conn, %{"coupon" => coupon_params}) do
    with {:ok, %Coupon{} = coupon} <- Shopping.create_coupon(coupon_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.coupon_path(conn, :show, coupon.uuid))
      |> render("show.json", coupon: coupon)
    end
  end

  def show(conn, %{"uuid" => uuid}) do
    coupon = Shopping.get_coupon!(uuid)
    render(conn, "show.json", coupon: coupon)
  end
end
