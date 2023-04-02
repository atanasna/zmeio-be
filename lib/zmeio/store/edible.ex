defmodule Zmeio.Store.Edible do
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
    field :storage, :float
    field :stack_weight, :float
    field :stack_price, :float
    belongs_to :edible_type, Zmeio.Store.EdibleType
    has_many :recipe_items, Zmeio.Store.RecipeItem

    timestamps()
  end

  @doc false
  def changeset(edible, attrs) do
    edible
    |> cast(attrs, [:name, :calories, :fat, :protein, :carbs, :fiber, :storage, :stack_weight, :stack_price])
    |> validate_required([:name, :calories, :fat, :protein, :carbs, :fiber, :storage, :stack_weight, :stack_price])
  end
end
