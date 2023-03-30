defmodule ZmeioWeb.GraphQL.Schema do
  use Absinthe.Schema

  import_types ZmeioWeb.GraphQL.Types.User
  import_types ZmeioWeb.GraphQL.Types.Session
  import_types ZmeioWeb.GraphQL.Queries.User
  import_types ZmeioWeb.GraphQL.Mutations.User
  
  query do
    import_fields :user_queries
  end

  mutation do
    import_fields :user_mutations
  end


end