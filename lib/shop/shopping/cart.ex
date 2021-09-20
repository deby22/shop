defmodule Shop.Shopping.Cart do
  use Ecto.Schema
  import Ecto.Changeset

  schema "carts" do
    field :value, :decimal
    field :discount, :integer, virtual: true
    embeds_many(:products, Shop.Shopping.Product, on_replace: :delete)
    timestamps()
  end

  @doc false
  def changeset(cart, attrs) do
    cart
    |> cast(attrs, [:discount])
    |> cast_embed(:products, required: true)
    |> sum_prices()
    |> apply_discount()
  end

  defp apply_discount(%Ecto.Changeset{changes: %{discount: discount, value: value}} = changeset) do
    discount_value =  Decimal.mult(value, discount) |> Decimal.div(100)
    calculated_value = Decimal.sub(value, discount_value)
    calculated_value = if calculated_value > 0, do: calculated_value, else: 0
    put_change(changeset, :value, calculated_value)
  end

  defp apply_discount(changeset), do: changeset

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
