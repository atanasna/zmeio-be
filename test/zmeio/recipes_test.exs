defmodule Zmeio.RecipesTest do
  use Zmeio.DataCase

  alias Zmeio.Store

  describe "recipe" do
    alias Zmeio.Store.Recipe

    import Zmeio.RecipesFixtures

    @invalid_attrs %{
      name: nil
    }

    test "list_recipe/0 returns all recipe" do
      recipe = recipe_fixture()
      assert Store.list_recipes() == [recipe]
    end

    test "get_recipe!/1 returns the recipe with given id" do
      recipe = recipe_fixture()
      assert Store.get_recipe!(recipe.id) == recipe
    end

    test "create_recipe/1 with valid data creates a recipe" do
      valid_attrs = %{name: "some recipe name here"}

      assert {:ok, %Recipe{}} = Store.create_recipe(valid_attrs)
    end

    test "create_recipe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_recipe(@invalid_attrs)
    end

    test "update_recipe/2 with valid data updates the recipe" do
      recipe = recipe_fixture()
      update_attrs = %{}

      assert {:ok, %Recipe{}} = Store.update_recipe(recipe, update_attrs)
    end

    test "update_recipe/2 with invalid data returns error changeset" do
      recipe = recipe_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_recipe(recipe, @invalid_attrs)
      assert recipe == Store.get_recipe!(recipe.id)
    end

    test "delete_recipe/1 deletes the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{}} = Store.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Store.get_recipe!(recipe.id) end
    end

    test "change_recipe/1 returns a recipe changeset" do
      recipe = recipe_fixture()
      assert %Ecto.Changeset{} = Store.change_recipe(recipe)
    end
  end
end
