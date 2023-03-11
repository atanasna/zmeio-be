defmodule ZmeioWeb.EdibleTypeController do
  use ZmeioWeb, :controller

  alias Zmeio.Store
  alias Zmeio.Store.EdibleType

  action_fallback ZmeioWeb.FallbackController

  def index(conn, _params) do
    edible_types = Store.list_edible_types()
    render(conn, :index, edible_types: edible_types)
  end

  def create(conn, %{"edible_type" => edible_type_params}) do
    with {:ok, %EdibleType{} = edible_type} <- Store.create_edible_type(edible_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/edible_types/#{edible_type}")
      |> render(:show, edible_type: edible_type)
    end
  end

  def show(conn, %{"id" => id}) do
    edible_type = Store.get_edible_type!(id)
    render(conn, :show, edible_type: edible_type)
  end

  def update(conn, %{"id" => id, "edible_type" => edible_type_params}) do
    edible_type = Store.get_edible_type!(id)

    with {:ok, %EdibleType{} = edible_type} <- Store.update_edible_type(edible_type, edible_type_params) do
      render(conn, :show, edible_type: edible_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    edible_type = Store.get_edible_type!(id)

    with {:ok, %EdibleType{}} <- Store.delete_edible_type(edible_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
