defmodule ZmeioWeb.GraphQL.Queries.User do
  use Absinthe.Schema.Notation

  alias ZmeioWeb.GraphQL.Resolvers

  object :user_queries do
    @desc "Get list with all users"
    field :user_index, list_of(:user) do
      resolve(&Resolvers.User.index/2)
    end

    @desc "Get user"
    field :user_show, :user do
      arg :id, non_null(:id)
      
      resolve(&Resolvers.User.show/2)
    end

    @desc "Get auth user profile"
    field :user_profile, :user do
      resolve(&Resolvers.User.profile/2)
    end
    
  end
end
