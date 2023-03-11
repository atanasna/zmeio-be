defmodule Zmeio.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :price, :float
    belongs_to :account, Zmeio.Accounts.Account
    has_many :order_items, Zmeio.OrderItems.OrderItem

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:price])
    |> validate_required([:price])
  end
end
