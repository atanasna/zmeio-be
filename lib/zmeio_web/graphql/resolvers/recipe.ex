defmodule ZmeioWeb.GraphQL.Resolvers.Recipe do

  import Ecto.Query, warn: false

  alias Zmeio.Identity.User
  alias Zmeio.Store.Recipe
  alias Zmeio.Store.RecipeItem
  
  def public(_args, _context) do
    {:ok, 
    Recipe 
    |> where(is_public: true) 
    |> Zmeio.Repo.all()}
  end

  def private(_args, %{context: %{user: user}}) do
    case user do
      nil -> {:ok, []}
      user -> 
        {:ok,
        Recipe
        |> where(is_public: false)
        |> where(user_id: ^user.id) 
        |> Zmeio.Repo.all()}
    end
  end
end
