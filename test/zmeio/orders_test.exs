defmodule Zmeio.OrdersTest do
  use Zmeio.DataCase

  alias Zmeio.Store

  describe "orders" do
    alias Zmeio.Store.Order

    import Zmeio.OrdersFixtures

    @invalid_attrs %{price: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Store.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Store.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{price: 120.5}

      assert {:ok, %Order{} = order} = Store.create_order(valid_attrs)
      assert order.price == 120.5
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{price: 456.7}

      assert {:ok, %Order{} = order} = Store.update_order(order, update_attrs)
      assert order.price == 456.7
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_order(order, @invalid_attrs)
      assert order == Store.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Store.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Store.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Store.change_order(order)
    end
  end
end
