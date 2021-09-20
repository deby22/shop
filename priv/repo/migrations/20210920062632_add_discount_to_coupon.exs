defmodule Shop.Repo.Migrations.AddDiscountToCoupon do
  use Ecto.Migration

  def change do
    alter table("coupons") do
      add :discount, :integer
    end
  end
end
