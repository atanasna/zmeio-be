defmodule ZmeioWeb.OrderItemJSON do
  alias Zmeio.OrderItems.OrderItem

  @doc """
  Renders a list of order_items.
  """
  def index(%{order_items: order_items}) do
    %{data: for(order_item <- order_items, do: data(order_item))}
  end

  @doc """
  Renders a single order_item.
  """
  def show(%{order_item: order_item}) do
    %{data: data(order_item)}
  end

  defp data(%OrderItem{} = order_item) do
    %{
      id: order_item.id,
      amount: order_item.amount
    }
  end
end
