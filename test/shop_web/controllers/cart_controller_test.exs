defmodule ShopWeb.CartControllerTest do
  use ShopWeb.ConnCase

  @create_attrs %{products: [%{name: "Test", price: 10.0}]}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all carts", %{conn: conn} do
      conn = get(conn, Routes.cart_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create cart" do
    test "renders cart when data is valid", %{conn: conn} do
      conn = post(conn, Routes.cart_path(conn, :create), cart: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.cart_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.cart_path(conn, :create), cart: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
