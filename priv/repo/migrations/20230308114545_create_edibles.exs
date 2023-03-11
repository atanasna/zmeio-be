defmodule Zmeio.Repo.Migrations.CreateEdibles do
  use Ecto.Migration

  def change do
    create table(:edibles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :calories, :float
      add :fat, :float
      add :protein, :float
      add :carbs, :float
      add :fiber, :float
      add :stock, :float
      add :batch_weight, :float
      add :batch_price, :float
      add :edible_type_id, references(:edible_types, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:edibles, [:edible_type_id])
    create index(:edibles, [:name])
  end
end
