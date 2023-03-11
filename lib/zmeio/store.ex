defmodule Zmeio.Store do
  @moduledoc """
  The Edibles context.
  """

  import Ecto.Query, warn: false
  alias Zmeio.Repo

  alias Zmeio.Store.Edible
  alias Zmeio.Store.EdibleType
  alias Zmeio.Store.Order
  alias Zmeio.Store.OrderItem
  alias Zmeio.Store.Recipe
  alias Zmeio.Store.RecipeItem

  ################################################
  # Edibles
  ################################################
  @doc """
  Returns the list of edibles.

  ## Examples

      iex> list_edibles()
      [%Edible{}, ...]

  """
  def list_edibles do
    Repo.all(Edible)
  end

  @doc """
  Gets a single edible.

  Raises `Ecto.NoResultsError` if the Edible does not exist.

  ## Examples

      iex> get_edible!(123)
      %Edible{}

      iex> get_edible!(456)
      ** (Ecto.NoResultsError)

  """
  def get_edible!(id), do: Repo.get!(Edible, id)

  def get_edible_by_name(name) do
    Edible
    |> where(name: ^name)
    |> Repo.one()
  end
  @doc """
  Creates a edible.

  ## Examples

      iex> create_edible(%{field: value})
      {:ok, %Edible{}}

      iex> create_edible(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_edible(attrs \\ %{}) do
    %Edible{}
    |> Edible.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a edible.

  ## Examples

      iex> update_edible(edible, %{field: new_value})
      {:ok, %Edible{}}

      iex> update_edible(edible, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_edible(%Edible{} = edible, attrs) do
    edible
    |> Edible.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a edible.

  ## Examples

      iex> delete_edible(edible)
      {:ok, %Edible{}}

      iex> delete_edible(edible)
      {:error, %Ecto.Changeset{}}

  """
  def delete_edible(%Edible{} = edible) do
    Repo.delete(edible)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking edible changes.

  ## Examples

      iex> change_edible(edible)
      %Ecto.Changeset{data: %Edible{}}

  """
  def change_edible(%Edible{} = edible, attrs \\ %{}) do
    Edible.changeset(edible, attrs)
  end

  ################################################
  # EdibleType
  ################################################
  @doc """
  Returns the list of edible_types.

  ## Examples

      iex> list_edible_types()
      [%EdibleType{}, ...]

  """
  def list_edible_types do
    Repo.all(EdibleType)
  end

  @doc """
  Gets a single edible_type.

  Raises `Ecto.NoResultsError` if the Edible type does not exist.

  ## Examples

      iex> get_edible_type!(123)
      %EdibleType{}

      iex> get_edible_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_edible_type!(id), do: Repo.get!(EdibleType, id)

  @doc """
  Creates a edible_type.

  ## Examples

      iex> create_edible_type(%{field: value})
      {:ok, %EdibleCategory{}}

      iex> create_edible_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_edible_type(attrs \\ %{}) do
    %EdibleType{}
    |> EdibleType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a edible_type.

  ## Examples

      iex> update_edible_type(edible_type, %{field: new_value})
      {:ok, %EdibleType{}}

      iex> update_edible_type(edible_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_edible_type(%EdibleType{} = edible_type, attrs) do
    edible_type
    |> EdibleType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a edible_type.

  ## Examples

      iex> delete_edible_type(edible_type)
      {:ok, %EdibleType{}}

      iex> delete_edible_type(edible_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_edible_type(%EdibleType{} = edible_type) do
    Repo.delete(edible_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking edible_type changes.

  ## Examples

      iex> change_edible_type(edible_type)
      %Ecto.Changeset{data: %EdibleType{}}

  """
  def change_edible_type(%EdibleType{} = edible_type, attrs \\ %{}) do
    EdibleType.changeset(edible_type, attrs)
  end

  ################################################
  # Recipe
  ################################################
  @doc """
  Returns the list of recipes.

  ## Examples

      iex> list_recipes()
      [%Recipe{}, ...]

  """
  def list_recipes do
    Repo.all(Recipe)
  end

  @doc """
  Gets a single recipe.

  Raises `Ecto.NoResultsError` if the Recipe does not exist.

  ## Examples

      iex> get_recipe!(123)
      %Recipe{}

      iex> get_recipe!(456)
      ** (Ecto.NoResultsError)

  """
  def get_recipe!(id), do: Repo.get!(Recipe, id)

  def get_recipe_by_name(name) do
    Recipe
    |> where(name: ^name)
    |> Repo.one()
  end
  @doc """
  Creates a recipe.

  ## Examples

      iex> create_recipe(%{field: value})
      {:ok, %Recipe{}}

      iex> create_recipe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_recipe(attrs \\ %{}) do
    %Recipe{}
    |> Recipe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a recipe.

  ## Examples

      iex> update_recipe(recipe, %{field: new_value})
      {:ok, %Recipe{}}

      iex> update_recipe(recipe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_recipe(%Recipe{} = recipe, attrs) do
    recipe
    |> Recipe.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a recipe.

  ## Examples

      iex> delete_recipe(recipe)
      {:ok, %Recipe{}}

      iex> delete_recipe(recipe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_recipe(%Recipe{} = recipe) do
    Repo.delete(recipe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recipe changes.

  ## Examples

      iex> change_recipe(recipe)
      %Ecto.Changeset{data: %Recipe{}}

  """
  def change_recipe(%Recipe{} = recipe, attrs \\ %{}) do
    Recipe.changeset(recipe, attrs)
  end
  ################################################
  # RecipeItem
  ################################################
  @doc """
  Returns the list of recipe_items.

  ## Examples

      iex> list_recipe_items()
      [%RecipeItem{}, ...]

  """
  def list_recipe_items do
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
  def get_recipe_item!(id), do: Repo.get!(RecipeItem, id)

  @doc """
  Creates a recipe_item.

  ## Examples

      iex> create_recipe_item(%{field: value})
      {:ok, %RecipeItem{}}

      iex> create_recipe_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_recipe_item(attrs \\ %{}) do
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
  def update_recipe_item(%RecipeItem{} = recipe_item, attrs) do
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
  def delete_recipe_item(%RecipeItem{} = recipe_item) do
    Repo.delete(recipe_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recipe_item changes.

  ## Examples

      iex> change_recipe_item(recipe_item)
      %Ecto.Changeset{data: %RecipeItem{}}

  """
  def change_recipe_item(%RecipeItem{} = recipe_item, attrs \\ %{}) do
    RecipeItem.changeset(recipe_item, attrs)
  end

  ################################################
  # Order
  ################################################
  def list_orders do
    Repo.all(Order)
  end

  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order!(id), do: Repo.get!(Order, id)

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order.

  ## Examples

      iex> delete_order(order)
      {:ok, %Order{}}

      iex> delete_order(order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{data: %Order{}}

  """
  def change_order(%Order{} = order, attrs \\ %{}) do
    Order.changeset(order, attrs)
  end

  ################################################
  # OrderItem
  ################################################
  @doc """
  Returns the list of order_items.

  ## Examples

      iex> list_order_items()
      [%OrderItem{}, ...]

  """
  def list_order_items do
    Repo.all(OrderItem)
  end

  @doc """
  Gets a single order_item.

  Raises `Ecto.NoResultsError` if the Order item does not exist.

  ## Examples

      iex> get_order_item!(123)
      %OrderItem{}

      iex> get_order_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order_item!(id), do: Repo.get!(OrderItem, id)

  @doc """
  Creates a order_item.

  ## Examples

      iex> create_order_item(%{field: value})
      {:ok, %OrderItem{}}

      iex> create_order_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order_item(attrs \\ %{}) do
    %OrderItem{}
    |> OrderItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order_item.

  ## Examples

      iex> update_order_item(order_item, %{field: new_value})
      {:ok, %OrderItem{}}

      iex> update_order_item(order_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order_item(%OrderItem{} = order_item, attrs) do
    order_item
    |> OrderItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order_item.

  ## Examples

      iex> delete_order_item(order_item)
      {:ok, %OrderItem{}}

      iex> delete_order_item(order_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order_item(%OrderItem{} = order_item) do
    Repo.delete(order_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order_item changes.

  ## Examples

      iex> change_order_item(order_item)
      %Ecto.Changeset{data: %OrderItem{}}

  """
  def change_order_item(%OrderItem{} = order_item, attrs \\ %{}) do
    OrderItem.changeset(order_item, attrs)
  end
end
