defmodule Zmeio.EdibleCategoriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Zmeio.EdibleCategories` context.
  """

  @doc """
  Generate a edible_category.
  """
  def edible_category_fixture(attrs \\ %{}) do
    {:ok, edible_category} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Zmeio.EdibleCategories.create_edible_category()

    edible_category
  end
end
