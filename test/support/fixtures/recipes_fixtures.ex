defmodule Zmeio.RecipesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Zmeio.Recipes` context.
  """

  @doc """
  Generate a recipe.
  """
  def recipe_fixture(attrs \\ %{}) do
    {:ok, recipe} =
      attrs
      |> Enum.into(%{

      })
      |> Zmeio.Recipes.create_recipe()

    recipe
  end
end
