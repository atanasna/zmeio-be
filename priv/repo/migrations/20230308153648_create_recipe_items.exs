defmodule Zmeio.Repo.Migrations.CreateRecipeItems do
  use Ecto.Migration

  def change do
    create table(:recipe_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :stacks, :integer
      add :recipe_id, references(:recipes, on_delete: :nothing, type: :binary_id)
      add :edible_id, references(:edibles, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:recipe_items, [:recipe_id])
    create index(:recipe_items, [:edible_id])
  end
end
