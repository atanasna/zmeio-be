defmodule Zmeio.EdiblesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Zmeio.Edibles` context.
  """

  @doc """
  Generate a edible.
  """
  def edible_fixture(attrs \\ %{}) do
    {:ok, edible} =
      attrs
      |> Enum.into(%{
        calories: 42,
        carbs: 42,
        fat: 42,
        fiber: 42,
        name: "some name",
        protein: 42,
        stock: 42
      })
      |> Zmeio.Edibles.create_edible()

    edible
  end
end
