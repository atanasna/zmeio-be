defmodule Zmeio.RecipeItemsTest do
  use Zmeio.DataCase

  alias Zmeio.RecipeItems

  describe "recipe_item" do
    alias Zmeio.RecipeItems.RecipeItem

    import Zmeio.RecipeItemsFixtures

    @invalid_attrs %{weight: nil}

    test "list_recipe_item/0 returns all recipe_item" do
      recipe_item = recipe_item_fixture()
      assert RecipeItems.list_recipe_item() == [recipe_item]
    end

    test "get_recipe_item!/1 returns the recipe_item with given id" do
      recipe_item = recipe_item_fixture()
      assert RecipeItems.get_recipe_item!(recipe_item.id) == recipe_item
    end

    test "create_recipe_item/1 with valid data creates a recipe_item" do
      valid_attrs = %{weight: 42}

      assert {:ok, %RecipeItem{} = recipe_item} = RecipeItems.create_recipe_item(valid_attrs)
      assert recipe_item.weight == 42
    end

    test "create_recipe_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RecipeItems.create_recipe_item(@invalid_attrs)
    end

    test "update_recipe_item/2 with valid data updates the recipe_item" do
      recipe_item = recipe_item_fixture()
      update_attrs = %{weight: 43}

      assert {:ok, %RecipeItem{} = recipe_item} = RecipeItems.update_recipe_item(recipe_item, update_attrs)
      assert recipe_item.weight == 43
    end

    test "update_recipe_item/2 with invalid data returns error changeset" do
      recipe_item = recipe_item_fixture()
      assert {:error, %Ecto.Changeset{}} = RecipeItems.update_recipe_item(recipe_item, @invalid_attrs)
      assert recipe_item == RecipeItems.get_recipe_item!(recipe_item.id)
    end

    test "delete_recipe_item/1 deletes the recipe_item" do
      recipe_item = recipe_item_fixture()
      assert {:ok, %RecipeItem{}} = RecipeItems.delete_recipe_item(recipe_item)
      assert_raise Ecto.NoResultsError, fn -> RecipeItems.get_recipe_item!(recipe_item.id) end
    end

    test "change_recipe_item/1 returns a recipe_item changeset" do
      recipe_item = recipe_item_fixture()
      assert %Ecto.Changeset{} = RecipeItems.change_recipe_item(recipe_item)
    end
  end
end
