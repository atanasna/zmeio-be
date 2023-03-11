defmodule ZmeioWeb.RecipeJSON do
  alias Zmeio.Store.Recipe

  @doc """
  Renders a list of recipe.
  """
  def index(%{recipe: recipe}) do
    %{data: for(recipe <- recipe, do: data(recipe))}
  end

  @doc """
  Renders a single recipe.
  """
  def show(%{recipe: recipe}) do
    %{data: data(recipe)}
  end

  defp data(%Recipe{} = recipe) do
    %{
      id: recipe.id
    }
  end
end
