defmodule Zmeio.EdiblesTest do
  use Zmeio.DataCase

  alias Zmeio.Edibles

  describe "edibles" do
    alias Zmeio.Edibles.Edible

    import Zmeio.EdiblesFixtures

    @invalid_attrs %{calories: nil, carbs: nil, fat: nil, fiber: nil, name: nil, protein: nil, stock: nil}

    test "list_edibles/0 returns all edibles" do
      edible = edible_fixture()
      assert Edibles.list_edibles() == [edible]
    end

    test "get_edible!/1 returns the edible with given id" do
      edible = edible_fixture()
      assert Edibles.get_edible!(edible.id) == edible
    end

    test "create_edible/1 with valid data creates a edible" do
      valid_attrs = %{calories: 42, carbs: 42, fat: 42, fiber: 42, name: "some name", protein: 42, stock: 42}

      assert {:ok, %Edible{} = edible} = Edibles.create_edible(valid_attrs)
      assert edible.calories == 42
      assert edible.carbs == 42
      assert edible.fat == 42
      assert edible.fiber == 42
      assert edible.name == "some name"
      assert edible.protein == 42
      assert edible.stock == 42
    end

    test "create_edible/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Edibles.create_edible(@invalid_attrs)
    end

    test "update_edible/2 with valid data updates the edible" do
      edible = edible_fixture()
      update_attrs = %{calories: 43, carbs: 43, fat: 43, fiber: 43, name: "some updated name", protein: 43, stock: 43}

      assert {:ok, %Edible{} = edible} = Edibles.update_edible(edible, update_attrs)
      assert edible.calories == 43
      assert edible.carbs == 43
      assert edible.fat == 43
      assert edible.fiber == 43
      assert edible.name == "some updated name"
      assert edible.protein == 43
      assert edible.stock == 43
    end

    test "update_edible/2 with invalid data returns error changeset" do
      edible = edible_fixture()
      assert {:error, %Ecto.Changeset{}} = Edibles.update_edible(edible, @invalid_attrs)
      assert edible == Edibles.get_edible!(edible.id)
    end

    test "delete_edible/1 deletes the edible" do
      edible = edible_fixture()
      assert {:ok, %Edible{}} = Edibles.delete_edible(edible)
      assert_raise Ecto.NoResultsError, fn -> Edibles.get_edible!(edible.id) end
    end

    test "change_edible/1 returns a edible changeset" do
      edible = edible_fixture()
      assert %Ecto.Changeset{} = Edibles.change_edible(edible)
    end
  end
end
