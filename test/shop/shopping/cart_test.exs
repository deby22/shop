defmodule Shop.Shoppin.CartTest do
  use ExUnit.Case, async: true
  alias Shop.Shopping.Cart
  alias Ecto.Changeset

  describe "changeset/2" do
    test "without products should return validation error" do
      {:error, %Changeset{errors: errors}} =
        %Cart{}
        |> Cart.changeset(%{products: []})
        |> Changeset.apply_action(:insert)

      assert errors[:products]
    end

    test "value should be calculated dynamicly" do
      {:ok, coupon} =
        %Cart{}
        |> Cart.changeset(%{
          products: [
            %{name: "first", price: 10.0},
            %{name: "second", price: 20.0},
            %{name: "third", price: 30.0}
          ]
        })
        |> Changeset.apply_action(:insert)

      assert Decimal.new("60.0") == coupon.value
    end
  end
end
