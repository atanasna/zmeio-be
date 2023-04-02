defmodule ZmeioWeb.GraphQL.Types.Recipe do
  use Absinthe.Schema.Notation
  
  import Ecto.Query, warn: false

  alias Zmeio.Store.Recipe
  alias Zmeio.Store.RecipeItem

  object :recipe do
    field :id, non_null(:id)
    field :name, non_null(:string)

    field :items, non_null(list_of(non_null(:recipe_item))) do
      resolve fn recipe, _args, _context ->
        {:ok, RecipeItem |> where(recipe_id: ^recipe.id) |> Zmeio.Repo.all()}
      end
    end
    
  end
end