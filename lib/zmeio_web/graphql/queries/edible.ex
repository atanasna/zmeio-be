defmodule ZmeioWeb.GraphQL.Queries.Edible do
  use Absinthe.Schema.Notation

  alias ZmeioWeb.GraphQL.Resolvers

  object :edible_queries do
    @desc "Get list of all edibles"
    field :edibles_index, list_of(:edible) do
      resolve(&Resolvers.Edible.index/2)
    end
  end
end
