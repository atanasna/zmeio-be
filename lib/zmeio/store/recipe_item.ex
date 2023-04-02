defmodule Zmeio.Store.RecipeItem do
  use Ecto.Schema
  import Ecto.Changeset

  alias Zmeio.Store

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "recipe_items" do
    field :stacks, :integer
    belongs_to :edible, Zmeio.Store.Edible
    belongs_to :recipe, Zmeio.Store.Recipe

    timestamps()
  end

  @doc false
  def changeset(recipe_item, attrs) do
    recipe_item
    |> cast(attrs, [:stacks])
    |> validate_required([:stacks])
  end

  # -- Custom
  def price(item) do
    edible = Store.get_edible!(item.edible_id)
    edible.stack_price * item.stacks
  end
end
