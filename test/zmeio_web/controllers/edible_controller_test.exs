defmodule ZmeioWeb.EdibleControllerTest do
  use ZmeioWeb.ConnCase

  import Zmeio.EdiblesFixtures

  alias Zmeio.Edibles.Edible

  @create_attrs %{
    calories: 42,
    carbs: 42,
    fat: 42,
    fiber: 42,
    name: "some name",
    protein: 42,
    stock: 42
  }
  @update_attrs %{
    calories: 43,
    carbs: 43,
    fat: 43,
    fiber: 43,
    name: "some updated name",
    protein: 43,
    stock: 43
  }
  @invalid_attrs %{calories: nil, carbs: nil, fat: nil, fiber: nil, name: nil, protein: nil, stock: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all edibles", %{conn: conn} do
      conn = get(conn, ~p"/api/edibles")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create edible" do
    test "renders edible when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/edibles", edible: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/edibles/#{id}")

      assert %{
               "id" => ^id,
               "calories" => 42,
               "carbs" => 42,
               "fat" => 42,
               "fiber" => 42,
               "name" => "some name",
               "protein" => 42,
               "stock" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/edibles", edible: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update edible" do
    setup [:create_edible]

    test "renders edible when data is valid", %{conn: conn, edible: %Edible{id: id} = edible} do
      conn = put(conn, ~p"/api/edibles/#{edible}", edible: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/edibles/#{id}")

      assert %{
               "id" => ^id,
               "calories" => 43,
               "carbs" => 43,
               "fat" => 43,
               "fiber" => 43,
               "name" => "some updated name",
               "protein" => 43,
               "stock" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, edible: edible} do
      conn = put(conn, ~p"/api/edibles/#{edible}", edible: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete edible" do
    setup [:create_edible]

    test "deletes chosen edible", %{conn: conn, edible: edible} do
      conn = delete(conn, ~p"/api/edibles/#{edible}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/edibles/#{edible}")
      end
    end
  end

  defp create_edible(_) do
    edible = edible_fixture()
    %{edible: edible}
  end
end
