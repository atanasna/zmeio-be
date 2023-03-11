defmodule Zmeio.OrderItems.OrderItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "order_items" do
    field :amount, :integer
    belongs_to :order, Zmeio.Orders.Order
    belongs_to :recipe, Zmeio.Recipes.Recipe

    timestamps()
  end

  @doc false
  def changeset(order_item, attrs) do
    order_item
    |> cast(attrs, [:amount])
    |> validate_required([:amount])
  end
end
