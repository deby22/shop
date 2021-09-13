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
  def changeset(cart, attrs) do
    cart
    |> cast(attrs, [:expired_at])
    |> validate_required(:expired_at)
  end
end
