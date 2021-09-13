defmodule ShopWeb.CouponControllerTest do
  use ShopWeb.ConnCase

  @create_attrs %{expired_at: NaiveDateTime.utc_now()}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all coupons", %{conn: conn} do
      conn = get(conn, Routes.coupon_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create coupon" do
    test "renders coupon when data is valid", %{conn: conn} do
      conn = post(conn, Routes.coupon_path(conn, :create), coupon: @create_attrs)
      assert %{"uuid" => uuid} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.coupon_path(conn, :show, uuid))

      assert %{
               "uuid" => ^uuid
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.coupon_path(conn, :create), coupon: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
