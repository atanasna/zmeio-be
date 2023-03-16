defmodule Zmeio.Identity.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :first_name, :string
    field :last_name, :string
    field :provider, :string
    field :token, :string
    field :avatar, :string
    has_many :orders, Zmeio.Store.Order
    has_many :recipes, Zmeio.Store.Recipe

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password_hash, :first_name, :last_name, :provider, :token, :avatar])
    |> validate_required([:email, :provider])
    |> validate_format(:email, ~r/^\S+@\S+$/, message: "must be an email")
    |> validate_length(:email, max: 160)
    |> unique_constraint(:email)
  end

end