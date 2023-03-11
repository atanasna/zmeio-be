defmodule Zmeio.EdibleTypes do
  @moduledoc """
  The EdibleTypes context.
  """

  import Ecto.Query, warn: false
  alias Zmeio.Repo

  alias Zmeio.EdibleTypes.EdibleType

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
end
