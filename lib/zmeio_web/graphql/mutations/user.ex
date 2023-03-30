defmodule ZmeioWeb.GraphQL.Mutations.User do
  use Absinthe.Schema.Notation

  alias ZmeioWeb.GraphQL.Resolvers

  object :user_mutations do
    field :register, :session do
      arg(:email, :string)
      arg(:password, :string)
      arg(:password_confirmation, :string)

      resolve(&Resolvers.User.register/2)
    end

    field :login, :session do
      arg(:email, :string)
      arg(:password, :string)
      
      resolve(&Resolvers.User.login/2)
    end
  end
end