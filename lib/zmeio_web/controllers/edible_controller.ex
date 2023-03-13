defmodule ZmeioWeb.EdibleController do
  use ZmeioWeb, :controller

  alias Zmeio.Store
  alias Zmeio.Store.Edible

  action_fallback ZmeioWeb.FallbackController

  def index(conn, _params) do
    edibles = Store.list_edibles()
    render(conn, :index, edibles: edibles)
  end

  def create(conn, %{"edible" => edible_params}) do
    with {:ok, %Edible{} = edible} <- Store.create_edible(edible_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/edibles/#{edible}")
      |> render(:show, edible: edible)
    end
  end

  def show(conn, %{"id" => id}) do
    edible = Store.get_edible!(id)

    render(conn, :show, edible: edible)
  end

  def update(conn, %{"id" => id, "edible" => edible_params}) do
    edible = Store.get_edible!(id)
    #IO.inspect(edible)
    with {:ok, %Edible{} = edible} <- Store.update_edible(edible, edible_params) do
      render(conn, :show, edible: edible)
    end
  end

  def delete(conn, %{"id" => id}) do
    edible = Store.get_edible!(id)

    with {:ok, %Edible{}} <- Store.delete_edible(edible) do
      send_resp(conn, :no_content, "")
    end
  end
end
