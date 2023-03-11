defmodule Zmeio.EdibleCategoriesTest do
  use Zmeio.DataCase

  alias Zmeio.EdibleCategories

  describe "edible_categories" do
    alias Zmeio.EdibleCategories.EdibleCategory

    import Zmeio.EdibleCategoriesFixtures

    @invalid_attrs %{name: nil}

    test "list_edible_categories/0 returns all edible_categories" do
      edible_category = edible_category_fixture()
      assert EdibleCategories.list_edible_categories() == [edible_category]
    end

    test "get_edible_category!/1 returns the edible_category with given id" do
      edible_category = edible_category_fixture()
      assert EdibleCategories.get_edible_category!(edible_category.id) == edible_category
    end

    test "create_edible_category/1 with valid data creates a edible_category" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %EdibleCategory{} = edible_category} = EdibleCategories.create_edible_category(valid_attrs)
      assert edible_category.name == "some name"
    end

    test "create_edible_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = EdibleCategories.create_edible_category(@invalid_attrs)
    end

    test "update_edible_category/2 with valid data updates the edible_category" do
      edible_category = edible_category_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %EdibleCategory{} = edible_category} = EdibleCategories.update_edible_category(edible_category, update_attrs)
      assert edible_category.name == "some updated name"
    end

    test "update_edible_category/2 with invalid data returns error changeset" do
      edible_category = edible_category_fixture()
      assert {:error, %Ecto.Changeset{}} = EdibleCategories.update_edible_category(edible_category, @invalid_attrs)
      assert edible_category == EdibleCategories.get_edible_category!(edible_category.id)
    end

    test "delete_edible_category/1 deletes the edible_category" do
      edible_category = edible_category_fixture()
      assert {:ok, %EdibleCategory{}} = EdibleCategories.delete_edible_category(edible_category)
      assert_raise Ecto.NoResultsError, fn -> EdibleCategories.get_edible_category!(edible_category.id) end
    end

    test "change_edible_category/1 returns a edible_category changeset" do
      edible_category = edible_category_fixture()
      assert %Ecto.Changeset{} = EdibleCategories.change_edible_category(edible_category)
    end
  end
end
