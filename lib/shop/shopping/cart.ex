defmodule Shop.Shopping.Cart do
  use Ecto.Schema
  import Ecto.Changeset

  schema "carts" do
    field :value, :decimal
    embeds_many(:products, Shop.Shopping.Product, on_replace: :delete)
    timestamps()
  end

  @doc false
  def changeset(cart, attrs) do
    cart
    |> cast(attrs, [])
    |> cast_embed(:products, required: true)
    |> validate_required([])
  end
end
