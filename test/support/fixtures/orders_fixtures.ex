defmodule Zmeio.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Zmeio.Store` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        price: 120.5
      })
      |> Zmeio.Store.create_order()

    order
  end
end
