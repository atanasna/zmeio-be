defmodule Zmeio.EdibleTypesTest do
  use Zmeio.DataCase

  alias Zmeio.Store

  describe "edible_types" do
    alias Zmeio.Store.EdibleType

    import Zmeio.EdibleTypesFixtures

    @invalid_attrs %{name: nil}

    test "list_edible_types/0 returns all edible_types" do
      edible_type = edible_type_fixture()
      assert Store.list_edible_types() == [edible_type]
    end

    test "get_edible_type!/1 returns the edible_type with given id" do
      edible_type = edible_type_fixture()
      assert Store.get_edible_type!(edible_type.id) == edible_type
    end

    test "create_edible_type/1 with valid data creates a edible_type" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %EdibleType{} = edible_type} = Store.create_edible_type(valid_attrs)
      assert edible_type.name == "some name"
    end

    test "create_edible_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_edible_type(@invalid_attrs)
    end

    test "update_edible_type/2 with valid data updates the edible_type" do
      edible_type = edible_type_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %EdibleType{} = edible_type} = Store.update_edible_type(edible_type, update_attrs)
      assert edible_type.name == "some updated name"
    end

    test "update_edible_type/2 with invalid data returns error changeset" do
      edible_type = edible_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_edible_type(edible_type, @invalid_attrs)
      assert edible_type == Store.get_edible_type!(edible_type.id)
    end

    test "delete_edible_type/1 deletes the edible_type" do
      edible_type = edible_type_fixture()
      assert {:ok, %EdibleType{}} = Store.delete_edible_type(edible_type)
      assert_raise Ecto.NoResultsError, fn -> Store.get_edible_type!(edible_type.id) end
    end

    test "change_edible_type/1 returns a edible_type changeset" do
      edible_type = edible_type_fixture()
      assert %Ecto.Changeset{} = Store.change_edible_type(edible_type)
    end
  end
end
