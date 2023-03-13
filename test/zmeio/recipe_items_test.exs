defmodule Zmeio.StoreTest do
  use Zmeio.DataCase

  alias Zmeio.Store

  describe "recipe_item" do
    alias Zmeio.Store.RecipeItem

    import Zmeio.RecipeItemsFixtures

    @invalid_attrs %{batches: nil}

    test "list_recipe_item/0 returns all recipe_item" do
      recipe_item = recipe_item_fixture()
      assert Store.list_recipe_items() == [recipe_item]
    end

    test "get_recipe_item!/1 returns the recipe_item with given id" do
      recipe_item = recipe_item_fixture()
      assert Store.get_recipe_item!(recipe_item.id) == recipe_item
    end

    test "create_recipe_item/1 with valid data creates a recipe_item" do
      valid_attrs = %{batches: 42}

      assert {:ok, %RecipeItem{} = recipe_item} = Store.create_recipe_item(valid_attrs)
      assert recipe_item.batches == 42
    end

    test "create_recipe_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_recipe_item(@invalid_attrs)
    end

    test "update_recipe_item/2 with valid data updates the recipe_item" do
      recipe_item = recipe_item_fixture()
      update_attrs = %{batches: 43}

      assert {:ok, %RecipeItem{} = recipe_item} = Store.update_recipe_item(recipe_item, update_attrs)
      assert recipe_item.batches == 43
    end

    test "update_recipe_item/2 with invalid data returns error changeset" do
      recipe_item = recipe_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_recipe_item(recipe_item, @invalid_attrs)
      assert recipe_item == Store.get_recipe_item!(recipe_item.id)
    end

    test "delete_recipe_item/1 deletes the recipe_item" do
      recipe_item = recipe_item_fixture()
      assert {:ok, %RecipeItem{}} = Store.delete_recipe_item(recipe_item)
      assert_raise Ecto.NoResultsError, fn -> Store.get_recipe_item!(recipe_item.id) end
    end

    test "change_recipe_item/1 returns a recipe_item changeset" do
      recipe_item = recipe_item_fixture()
      assert %Ecto.Changeset{} = Store.change_recipe_item(recipe_item)
    end
  end
end
