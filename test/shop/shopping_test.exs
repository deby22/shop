defmodule Shop.ShoppingTest do
  use Shop.DataCase

  alias Shop.Shopping

  describe "carts" do
    alias Shop.Shopping.Cart

    def cart_fixture(attrs) do
      {:ok, cart} = Shopping.create_cart(attrs)
      cart
    end

    test "list_carts/0 returns all carts" do
      valid_attrs = %{products: [%{name: "Test", price: 10.0}]}
      new_cart = cart_fixture(valid_attrs)
      [cart] = Shopping.list_carts()
      assert cart.id == new_cart.id
    end

    test "get_cart!/1 returns the cart with given id" do
      valid_attrs = %{products: [%{name: "Test", price: 10.0}]}
      new_cart = cart_fixture(valid_attrs)
      cart = Shopping.get_cart!(new_cart.id)
      assert cart.id == new_cart.id
    end

    test "create_cart/1 with valid data creates a cart" do
      valid_attrs = %{products: [%{name: "Test", price: 10.0}]}
      assert {:ok, %Cart{}} = Shopping.create_cart(valid_attrs)
    end

    test "create_cart/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shopping.create_cart(%{})
    end
  end

  describe "cart with coupon" do
    test "create cart with valid coupon should use coupon and apply discount" do
      tommorow = NaiveDateTime.utc_now() |> NaiveDateTime.add(24 * 60 * 60)
      {:ok, coupon} = Shopping.create_coupon(%{expired_at: tommorow, discount: 10})
      {:ok, cart} = Shopping.create_cart_with_coupon(%{products: [%{name: "Test", price: 10.0}], coupon: coupon.uuid})
      assert Decimal.new("9.0") == cart.value
    end
  end
  describe "coupons" do
    alias Shop.Shopping.Coupon

    def coupon_fixture(attrs) do
      {:ok, coupon} = Shopping.create_coupon(attrs)
      coupon
    end

    test "list_coupon/0 returns all coupons" do
      tommorow = NaiveDateTime.utc_now() |> NaiveDateTime.add(24 * 60 * 60)
      coupon = coupon_fixture(%{expired_at: tommorow})
      assert Shopping.list_coupons() == [coupon]
    end

    test "get_coupon!/1 returns the coupon with given uuid" do
      tommorow = NaiveDateTime.utc_now() |> NaiveDateTime.add(24 * 60 * 60)
      coupon = coupon_fixture(%{expired_at: tommorow})
      assert Shopping.get_coupon!(coupon.uuid) == coupon
    end

    test "create_coupon/1 with valid data creates a coupon" do
      tommorow = NaiveDateTime.utc_now() |> NaiveDateTime.add(24 * 60 * 60)
      assert {:ok, %Coupon{}} = Shopping.create_coupon(%{expired_at: tommorow})
    end

    test "create_coupon/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shopping.create_coupon(%{})
    end
  end
end
