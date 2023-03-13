defmodule Zmeio.EdiblesTest do
  use Zmeio.DataCase

  alias Zmeio.Store

  describe "edibles" do
    alias Zmeio.Store.Edible

    import Zmeio.EdiblesFixtures

    @invalid_attrs %{calories: nil, carbs: nil, fat: nil, fiber: nil, name: nil, protein: nil, stock: nil, batch_price: nil, batch_weight: nil}

    test "list_edibles/0 returns all edibles" do
      edible = edible_fixture()
      assert Store.list_edibles() == [edible]
    end

    test "get_edible!/1 returns the edible with given id" do
      edible = edible_fixture()
      assert Store.get_edible!(edible.id) == edible
    end

    test "create_edible/1 with valid data creates a edible" do
      valid_attrs = %{calories: 42, carbs: 42, fat: 42, fiber: 42, name: "some name", protein: 42, stock: 42, batch_price: 2.2, batch_weight: 100.0}

      assert {:ok, %Edible{} = edible} = Store.create_edible(valid_attrs)
      assert edible.calories == 42.0
      assert edible.carbs == 42.0
      assert edible.fat == 42.0
      assert edible.fiber == 42.0
      assert edible.name == "some name"
      assert edible.protein == 42.0
      assert edible.stock == 42.0
      assert edible.batch_price == 2.2
      assert edible.batch_weight == 100.0
    end

    test "create_edible/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_edible(@invalid_attrs)
    end

    test "update_edible/2 with valid data updates the edible" do
      edible = edible_fixture()
      update_attrs = %{calories: 43, carbs: 43, fat: 43, fiber: 43, name: "some updated name", protein: 43, stock: 43, batch_price: 3.2, batch_weight: 101.0}

      assert {:ok, %Edible{} = edible} = Store.update_edible(edible, update_attrs)
      assert edible.calories == 43
      assert edible.carbs == 43
      assert edible.fat == 43
      assert edible.fiber == 43
      assert edible.name == "some updated name"
      assert edible.protein == 43
      assert edible.stock == 43
      assert edible.batch_price == 3.2
      assert edible.batch_weight == 101.0
    end

    test "update_edible/2 with invalid data returns error changeset" do
      edible = edible_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_edible(edible, @invalid_attrs)
      assert edible == Store.get_edible!(edible.id)
    end

    test "delete_edible/1 deletes the edible" do
      edible = edible_fixture()
      assert {:ok, %Edible{}} = Store.delete_edible(edible)
      assert_raise Ecto.NoResultsError, fn -> Store.get_edible!(edible.id) end
    end

    test "change_edible/1 returns a edible changeset" do
      edible = edible_fixture()
      assert %Ecto.Changeset{} = Store.change_edible(edible)
    end
  end
end
