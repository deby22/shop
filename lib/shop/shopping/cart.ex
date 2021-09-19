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
    |> sum_prices()
  end

  defp sum_prices(changeset) do
    value =
      changeset
      |> get_products()
      |> extract_prices()
      |> sum()

    put_change(changeset, :value, value)
  end

  defp get_products(%Ecto.Changeset{changes: %{products: products}}),
    do: Enum.map(products, fn product -> product.changes end)

  defp get_products(_), do: []
  defp extract_prices(products), do: Enum.map(products, fn product -> product.price end)
  defp sum([price]), do: price
  defp sum([]), do: 0
  defp sum([price | prices]), do: Decimal.add(price, sum(prices))
end
