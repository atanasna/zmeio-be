defmodule Zmeio.OrderItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Zmeio.Store` context.
  """

  @doc """
  Generate a order_item.
  """
  def order_item_fixture(attrs \\ %{}) do
    {:ok, order_item} =
      attrs
      |> Enum.into(%{
        amount: 42
      })
      |> Zmeio.Store.create_order_item()

    order_item
  end
end
