defmodule Zmeio.Store.OrderItem do
  use Ecto.Schema
  import Ecto.Changeset

  alias Zmeio.Store

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "order_items" do
    field :amount, :integer
    belongs_to :order, Zmeio.Store.Order
    belongs_to :recipe, Zmeio.Store.Recipe

    timestamps()
  end

  @doc false
  def changeset(order_item, attrs) do
    order_item
    |> cast(attrs, [:amount])
    |> validate_required([:amount])
  end

  # -- Custom
  def price(item) do
    recipe = Store.get_recipe!(item.recipe_id)
    Store.Recipe.price(recipe) * item.amount
  end

end
