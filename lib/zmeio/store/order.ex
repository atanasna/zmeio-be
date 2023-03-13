defmodule Zmeio.Store.Order do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false

  alias Zmeio.Repo
  alias Zmeio.Store.OrderItem

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "orders" do
    field :price, :float
    belongs_to :user, Zmeio.Auth.User
    has_many :order_items, Zmeio.Store.OrderItem

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:price])
    |> validate_required([:price])
  end

  # -- Custom
  def items(order) do
    OrderItem
    |> where(order_id: ^order.id)
    |> Repo.all
  end

  def price(order) do
    items(order)
    |> Enum.map(fn item -> OrderItem.price(item) end)
    |> Enum.sum
  end
end
