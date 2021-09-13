defmodule Shop.Repo.Migrations.CreateCarts do
  use Ecto.Migration

  def change do
    create table(:carts) do
      add :value, :decimal
      add :products, {:array, :jsonb}, default: []
      timestamps()
    end
  end
end
