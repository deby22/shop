defmodule Shop.Shopping do
  @moduledoc false

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Shopping.{Cart, Coupon}

  def list_carts do
    Repo.all(Cart)
  end

  def get_cart!(id), do: Repo.get!(Cart, id)

  def create_cart(attrs) do
    %Cart{}
    |> Cart.changeset(attrs)
    |> Repo.insert()
  end

  def list_coupons do
    Repo.all(Coupon)
  end

  def get_coupon!(uuid), do: Repo.get!(Coupon, uuid)

  def create_coupon(attrs) do
    %Coupon{}
    |> Coupon.changeset(attrs)
    |> Repo.insert()
  end
end
