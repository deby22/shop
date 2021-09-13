defmodule Shop.Shopping.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :name, :string
    field :price, :decimal

    belongs_to :cart, Shop.Shopping.Cart
  end

  def changeset(cart, attrs) do
    cast(cart, attrs, [:name, :price])
  end
end
