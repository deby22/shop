defmodule Shop.Shoppin.CouponTest do
  use ExUnit.Case, async: true
  alias Shop.Shopping.Coupon
  alias Ecto.Changeset

  describe "changeset/2" do
    test "expired_at in the past should return validation error" do
      past_date = NaiveDateTime.utc_now() |> NaiveDateTime.add(-10)

      {:error, %Changeset{errors: errors}} =
        %Coupon{}
        |> Coupon.changeset(%{expired_at: past_date})
        |> Changeset.apply_action(:insert)

      assert errors[:expired_at]
    end

    test "expired_at as current time should return validation error" do
      current_date = NaiveDateTime.utc_now()

      {:error, %Changeset{errors: errors}} =
        %Coupon{}
        |> Coupon.changeset(%{expired_at: current_date})
        |> Changeset.apply_action(:insert)

      assert errors[:expired_at]
    end

    test "should accept expired_at  in the future" do
      future_date = NaiveDateTime.utc_now() |> NaiveDateTime.add(10)

      {:ok, coupon} =
        %Coupon{}
        |> Coupon.changeset(%{expired_at: future_date})
        |> Changeset.apply_action(:insert)

      assert -10 == NaiveDateTime.utc_now() |> NaiveDateTime.diff(coupon.expired_at)
    end

    test "discount cannot be lower than 0" do
      future_date = NaiveDateTime.utc_now() |> NaiveDateTime.add(10)

      {:error, %Changeset{errors: errors}} =
        %Coupon{}
        |> Coupon.changeset(%{expired_at: future_date, discount: -10})
        |> Changeset.apply_action(:insert)

      assert errors[:discount]
    end

    test "discount cannot be higher than 100" do
      future_date = NaiveDateTime.utc_now() |> NaiveDateTime.add(10)

      {:error, %Changeset{errors: errors}} =
        %Coupon{}
        |> Coupon.changeset(%{expired_at: future_date, discount: 101})
        |> Changeset.apply_action(:insert)

      assert errors[:discount]
    end
  end

  describe "use/1" do
    test "should set status as 'used'" do
      {:ok, coupon} =
        %Coupon{}
        |> Coupon.use()
        |> Changeset.apply_action(:insert)

      assert coupon.status == :used
    end
  end
end
