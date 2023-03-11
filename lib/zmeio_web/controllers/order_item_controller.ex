defmodule ZmeioWeb.OrderItemController do
  use ZmeioWeb, :controller

  alias Zmeio.OrderItems
  alias Zmeio.OrderItems.OrderItem

  action_fallback ZmeioWeb.FallbackController

  def index(conn, _params) do
    order_items = OrderItems.list_order_items()
    render(conn, :index, order_items: order_items)
  end

  def create(conn, %{"order_item" => order_item_params}) do
    with {:ok, %OrderItem{} = order_item} <- OrderItems.create_order_item(order_item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/order_items/#{order_item}")
      |> render(:show, order_item: order_item)
    end
  end

  def show(conn, %{"id" => id}) do
    order_item = OrderItems.get_order_item!(id)
    render(conn, :show, order_item: order_item)
  end

  def update(conn, %{"id" => id, "order_item" => order_item_params}) do
    order_item = OrderItems.get_order_item!(id)

    with {:ok, %OrderItem{} = order_item} <- OrderItems.update_order_item(order_item, order_item_params) do
      render(conn, :show, order_item: order_item)
    end
  end

  def delete(conn, %{"id" => id}) do
    order_item = OrderItems.get_order_item!(id)

    with {:ok, %OrderItem{}} <- OrderItems.delete_order_item(order_item) do
      send_resp(conn, :no_content, "")
    end
  end
end
