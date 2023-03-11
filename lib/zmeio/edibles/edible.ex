defmodule Zmeio.Edibles.Edible do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "edibles" do
    field :calories, :float
    field :carbs, :float
    field :fat, :float
    field :fiber, :float
    field :name, :string
    field :protein, :float
    field :stock, :float
    field :batch_weight, :float
    field :batch_price, :float
    belongs_to :edible_type, Zmeio.EdibleTypes.EdibleType
    has_many :recipe_items, Zmeio.RecipeItems.RecipeItem

    timestamps()
  end

  @doc false
  def changeset(edible, attrs) do
    edible
    |> cast(attrs, [:name, :calories, :fat, :protein, :carbs, :fiber, :stock])
    |> validate_required([:name, :calories, :fat, :protein, :carbs, :fiber, :stock])
  end
end
