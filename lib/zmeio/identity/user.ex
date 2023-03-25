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
    field :is_admin, :boolean, default: false
    field :provider, :string, default: "local"
    field :token, :string
    field :avatar, :string
    has_many :orders, Zmeio.Store.Order
    has_many :recipes, Zmeio.Store.Recipe

    timestamps()
  end

  def reset_password_changeset(user, attrs) do
    user
    |> update_changeset(attrs)
    |> cast(attrs, [:password, :password_confirmation])
    |> validate_required([:password, :password_confirmation])
    |> validate_length(:password, min: 12) # Check that password length is >= 8
    |> validate_confirmation(:password)
    |> put_password_hash()
  end

  def update_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :is_admin, :first_name, :last_name, :provider, :avatar])
    |> validate_required([:email, :provider])
    |> validate_format(:email, ~r/^\S+@\S+$/, message: "must be a valid email address")
    |> validate_length(:email, max: 160, message: "must be less than 160 characters long")
    |> unique_constraint(:email)
  end

  def create_changeset(user, attrs) do
    user
    |> update_changeset(attrs)
    |> reset_password_changeset(attrs)
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
