defmodule ZmeioWeb.GraphQL.Types.RecipeItem do
  use Absinthe.Schema.Notation

  import Ecto.Query, warn: false

  alias Zmeio.Store.Edible

  object :recipe_item do
    field :id, non_null(:id)

    field :edible, non_null(:edible) do
      resolve fn recipe_item, _args, _context ->
        IO.inspect recipe_item
        {:ok, Edible |> where(id: ^recipe_item.edible_id) |> Zmeio.Repo.one()}
      end
  end

    field :stacks, non_null(:integer)
  end
end