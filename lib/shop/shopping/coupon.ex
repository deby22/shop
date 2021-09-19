defmodule Shop.Shopping.Coupon do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: true}
  schema "coupons" do
    field :status, Ecto.Enum, values: [:new, :used], default: :new
    field :expired_at, :naive_datetime
    timestamps()
  end

  @doc false
  def changeset(coupon, attrs) do
    coupon
    |> cast(attrs, [:expired_at])
    |> validate_required(:expired_at)
    |> validate_expired_at()
  end

  defp validate_expired_at(changeset) do
    validate_change(changeset, :expired_at, fn :expired_at, expired_at ->
      diff = NaiveDateTime.utc_now() |> NaiveDateTime.diff(expired_at)
      if diff < 0, do: [], else: [expired_at: "should be in the future"]
    end)
  end

  def use(coupon), do: change(coupon, status: :used)
end
