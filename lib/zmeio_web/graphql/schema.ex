defmodule ZmeioWeb.GraphQL.Schema do
  use Absinthe.Schema

  import_types ZmeioWeb.GraphQL.Types.User
  import_types ZmeioWeb.GraphQL.Types.Session
  import_types ZmeioWeb.GraphQL.Types.Edible
  import_types ZmeioWeb.GraphQL.Types.Recipe
  import_types ZmeioWeb.GraphQL.Types.RecipeItem
  import_types ZmeioWeb.GraphQL.Queries.User
  import_types ZmeioWeb.GraphQL.Queries.Edible
  import_types ZmeioWeb.GraphQL.Queries.Recipe
  import_types ZmeioWeb.GraphQL.Mutations.User
  
  query do
    import_fields :user_queries
    import_fields :edible_queries
    import_fields :recipe_queries
  end

  mutation do
    import_fields :user_mutations
  end

end