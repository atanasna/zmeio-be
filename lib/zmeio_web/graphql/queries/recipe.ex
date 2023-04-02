defmodule ZmeioWeb.GraphQL.Queries.Recipe do
  use Absinthe.Schema.Notation

  alias ZmeioWeb.GraphQL.Resolvers

  object :recipe_queries do
    @desc "Get list with all public recipes"
    field :recipes_public, list_of(:recipe) do
      resolve(&Resolvers.Recipe.public/2)
    end

    @desc "Get list with all private recipes"
    field :recipes_private, list_of(:recipe) do
      resolve(&Resolvers.Recipe.private/2)
    end

    #@desc "Get user"
    #field :show, :user do
    #  arg :id, non_null(:id)
    #  
    #  resolve(&Resolvers.User.show/2)
    #end
#
    #@desc "Get auth user profile"
    #field :profile, :user do
    #  resolve(&Resolvers.User.profile/2)
    #end
    
  end
end
