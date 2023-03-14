#defmodule Zmeio.Accounts.Account do
#  use Ecto.Schema
#  import Ecto.Changeset
#
#  @primary_key {:id, :binary_id, autogenerate: true}
#  @foreign_key_type :binary_id
#  schema "accounts" do
#    field :email, :string
#    field :password_hash, :string
#    has_one :user, Zmeio.Users.User
#    has_many :orders, Zmeio.Store.Order
#    has_many :recipes, Zmeio.Store.Recipe
#
#    timestamps()
#  end
#
#  @doc false
#  def changeset(account, attrs) do
#    account
#    |> cast(attrs, [:email, :password_hash])
#    |> validate_required([:email, :password_hash])
#    |> validate_format(:email, ~r/^\S+@\S+$/, message: "must be an email")
#    |> validate_length(:email, max: 160)
#    |> unique_constraint(:email)
#    |> put_password_hash()
#  end
#
#  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password_hash: password_hash}} = changeset) do
#    change(changeset, password_hash: Bcrypt.hash_pwd_salt(password_hash))
#  end
#  defp put_password_hash(changeset), do: changeset
#
#end
