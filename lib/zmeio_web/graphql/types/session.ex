defmodule ZmeioWeb.GraphQL.Types.Session do
  use Absinthe.Schema.Notation

  object :session do
    field :token, non_null(:string)
    field :email, non_null(:string)
    field :id, non_null(:string)
  end
end