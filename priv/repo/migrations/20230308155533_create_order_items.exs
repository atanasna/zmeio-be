defmodule Zmeio.Repo.Migrations.CreateOrderItems do
  use Ecto.Migration

  def change do
    create table(:order_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :amount, :integer
      add :order_id, references(:orders, on_delete: :nothing, type: :binary_id)
      add :recipe_id, references(:recipes, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:order_items, [:order_id])
    create index(:order_items, [:recipe_id])
  end
end
