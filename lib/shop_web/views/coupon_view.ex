defmodule ShopWeb.CouponView do
  use ShopWeb, :view
  alias ShopWeb.CouponView

  def render("index.json", %{coupons: coupons}) do
    %{data: render_many(coupons, CouponView, "coupon.json")}
  end

  def render("show.json", %{coupon: coupon}) do
    %{data: render_one(coupon, CouponView, "coupon.json")}
  end

  def render("coupon.json", %{coupon: coupon}) do
    %{uuid: coupon.uuid, expired_at: coupon.expired_at, status: coupon.status}
  end
end
