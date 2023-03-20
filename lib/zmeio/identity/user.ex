defmodule Zmeio.Identity.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
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
    |> cast(attrs, [:email, :password, :password_confirmation, :password_hash, :first_name, :last_name, :provider, :token, :avatar])
    |> validate_required([:email, :password, :password_confirmation, :provider])
    |> validate_format(:email, ~r/^\S+@\S+$/, message: "must be a valid email address")
    |> validate_length(:email, max: 160, message: "must be less than 160 characters long")
    |> validate_length(:password, min: 12) # Check that password length is >= 8
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pass))
      _ -> changeset
    end
  end

  def generate_password() do
    for _ <- 1..30, into: "", do: <<Enum.random('0123456789abcdef')>>
  end
end
