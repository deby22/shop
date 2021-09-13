defmodule Shop.ShoppingTest do
  use Shop.DataCase

  alias Shop.Shopping

  describe "carts" do
    alias Shop.Shopping.Cart

    @valid_attrs %{products: [%{name: "Test", price: 10.0}]}
    @invalid_attrs %{}

    def cart_fixture(attrs \\ %{}) do
      {:ok, cart} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shopping.create_cart()

      cart
    end

    test "list_carts/0 returns all carts" do
      cart = cart_fixture()
      assert Shopping.list_carts() == [cart]
    end

    test "get_cart!/1 returns the cart with given id" do
      cart = cart_fixture()
      assert Shopping.get_cart!(cart.id) == cart
    end

    test "create_cart/1 with valid data creates a cart" do
      assert {:ok, %Cart{}} = Shopping.create_cart(@valid_attrs)
    end

    test "create_cart/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shopping.create_cart(@invalid_attrs)
    end
  end
end
