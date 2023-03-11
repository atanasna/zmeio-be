defmodule Zmeio.RecipeItems do
  @moduledoc """
  The RecipeItems context.
  """

  import Ecto.Query, warn: false
  alias Zmeio.Repo

  alias Zmeio.RecipeItems.RecipeItem

  @doc """
  Returns the list of recipe_items.

  ## Examples

      iex> list_recipe_items()
      [%RecipeItem{}, ...]

  """
  def list do
    Repo.all(RecipeItem)
  end

  @doc """
  Gets a single recipe_item.

  Raises `Ecto.NoResultsError` if the Recipe item does not exist.

  ## Examples

      iex> get_recipe_item!(123)
      %RecipeItem{}

      iex> get_recipe_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(RecipeItem, id)

  @doc """
  Creates a recipe_item.

  ## Examples

      iex> create_recipe_item(%{field: value})
      {:ok, %RecipeItem{}}

      iex> create_recipe_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %RecipeItem{}
    |> RecipeItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a recipe_item.

  ## Examples

      iex> update_recipe_item(recipe_item, %{field: new_value})
      {:ok, %RecipeItem{}}

      iex> update_recipe_item(recipe_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%RecipeItem{} = recipe_item, attrs) do
    recipe_item
    |> RecipeItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a recipe_item.

  ## Examples

      iex> delete_recipe_item(recipe_item)
      {:ok, %RecipeItem{}}

      iex> delete_recipe_item(recipe_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%RecipeItem{} = recipe_item) do
    Repo.delete(recipe_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recipe_item changes.

  ## Examples

      iex> change_recipe_item(recipe_item)
      %Ecto.Changeset{data: %RecipeItem{}}

  """
  def change(%RecipeItem{} = recipe_item, attrs \\ %{}) do
    RecipeItem.changeset(recipe_item, attrs)
  end

end
