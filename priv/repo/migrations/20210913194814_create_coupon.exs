defmodule Shop.Repo.Migrations.CreateCoupon do
  use Ecto.Migration

  def change do
    create table("coupons", primary_key: false) do
      add :status, :string
      add :expired_at, :naive_datetime
      add :uuid, :binary_id, primary_key: true
      timestamps()
    end
  end
end
