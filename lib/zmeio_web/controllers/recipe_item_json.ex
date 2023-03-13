defmodule ZmeioWeb.RecipeItemJSON do
  alias Zmeio.Store.RecipeItem

  @doc """
  Renders a list of recipe_item.
  """
  def index(%{recipe_item: recipe_item}) do
    %{data: for(recipe_item <- recipe_item, do: data(recipe_item))}
  end

  @doc """
  Renders a single recipe_item.
  """
  def show(%{recipe_item: recipe_item}) do
    %{data: data(recipe_item)}
  end

  defp data(%RecipeItem{} = recipe_item) do
    %{
      id: recipe_item.id,
      batches: recipe_item.batches
    }
  end
end
