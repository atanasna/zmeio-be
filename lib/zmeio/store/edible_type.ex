defmodule Zmeio.Store.EdibleType do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "edible_types" do
    field :name, :string
    has_many :edibles, Zmeio.Store.Edible

    timestamps()
  end

  @doc false
  def changeset(edible_type, attrs) do
    edible_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
