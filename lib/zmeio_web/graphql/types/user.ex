defmodule ZmeioWeb.GraphQL.Types.User do
  use Absinthe.Schema.Notation

  object :user do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :first_name, :string
    field :last_name, :string
    field :role, non_null(:string)
    field :avatar, :string
  end
end