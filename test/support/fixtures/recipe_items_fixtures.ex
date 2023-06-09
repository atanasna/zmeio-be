defmodule Zmeio.RecipeItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Zmeio.RecipeItems` context.
  """

  @doc """
  Generate a recipe_item.
  """
  def recipe_item_fixture(attrs \\ %{}) do
    {:ok, recipe_item} =
      attrs
      |> Enum.into(%{ stacks: 42 })
      |> Zmeio.Store.create_recipe_item()

    recipe_item
  end
end
