defmodule Zmeio.Edibles do
  @moduledoc """
  The Edibles context.
  """

  import Ecto.Query, warn: false
  alias Zmeio.Repo

  alias Zmeio.Edibles.Edible

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

  def get_by_name(name) do
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
end
