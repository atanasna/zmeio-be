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
        calories: 42.0,
        carbs: 42.0,
        fat: 42.0,
        fiber: 42.0,
        name: "some name",
        protein: 42.0,
        stock: 42.0,
        batch_weight: 100.0,
        batch_price: 2.2
      })
      |> Zmeio.Store.create_edible()
    edible
  end
end
