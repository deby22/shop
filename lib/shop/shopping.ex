defmodule Shop.Shopping do
  @moduledoc false

  # todo:
  # if coupons is valid on create_cart get discount value
  # acceptance/integration test
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

  def create_cart_with_coupon(%{coupon: coupon_uuid} = attrs) do
    case get_coupon(coupon_uuid) do
      nil -> create_cart(attrs)
      coupon ->
        use_coupon(coupon)
        attrs
        |> Map.put(:discount, coupon.discount)
        |> create_cart()
    end
  end

  def list_coupons do
    Repo.all(Coupon)
  end

  defp use_coupon(coupon), do: Coupon.use(coupon) |> Repo.update()
  def get_coupon!(uuid), do: Repo.get!(Coupon, uuid)
  def get_coupon(uuid), do: Repo.get(Coupon, uuid)

  def create_coupon(attrs) do
    %Coupon{}
    |> Coupon.changeset(attrs)
    |> Repo.insert()
  end
end
