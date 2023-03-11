defmodule Zmeio.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false

  alias Zmeio.Repo
  alias Zmeio.RecipeItems.RecipeItem

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "recipes" do
    field :name, :string
    belongs_to :account, Zmeio.Accounts.Account
    has_many :recipe_items, Zmeio.RecipeItems.RecipeItem
    has_many :order_items, Zmeio.OrderItems.OrderItem

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [])
    |> validate_required([])
  end

  # -- Custom
  def items(recipe) do
    RecipeItem
    |> where(recipe_id: ^recipe.id)
    |> Repo.all
  end

  def price(recipe) do
    items(recipe)
    |> Enum.map(fn item -> RecipeItem.price(item) end)
    |> Enum.sum
  end
end
