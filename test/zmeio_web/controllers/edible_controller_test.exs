defmodule ZmeioWeb.EdibleControllerTest do
  use ZmeioWeb.ConnCase

  import Zmeio.EdiblesFixtures

  alias Zmeio.Store.Edible

  @create_attrs %{
    calories: 42.0,
    carbs: 42.0,
    fat: 42.0,
    fiber: 42.0,
    name: "some name",
    protein: 42.0,
    stock: 42.0,
    batch_price: 2.2,
    batch_weight: 100.0
  }
  @update_attrs %{
    calories: 43.0,
    carbs: 43.0,
    fat: 43.0,
    fiber: 43.0,
    name: "some updated name",
    protein: 43.0,
    stock: 43.0,
    batch_price: 3.2,
    batch_weight: 101.0,
  }
  @invalid_attrs %{
    calories: nil,
    carbs: nil,
    fat: nil,
    fiber: nil,
    name: nil,
    protein: nil,
    stock: nil,
    batch_price: nil,
    batch_weight: nil
  }

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
               "calories" => 42.0,
               "carbs" => 42.0,
               "fat" => 42.0,
               "fiber" => 42.0,
               "name" => "some name",
               "protein" => 42.0,
               "stock" => 42.0,
               "batch_price" => 2.2,
               "batch_weight" => 100.0,
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
      #IO.inspect(edible)
      conn = put(conn, ~p"/api/edibles/#{edible}", edible: @update_attrs)
      #IO.inspect(@update_attrs)
      #IO.inspect(json_response(conn, 200)["data"])
      #IO.inspect(conn.resp_body)
      #IO.inspect(json_response(conn, 200))
      assert %{"id" => ^id} = json_response(conn, 200)["data"]


      conn = get(conn, ~p"/api/edibles/#{id}")

      assert %{
               "id" => ^id,
               "calories" => 43.0,
               "carbs" => 43.0,
               "fat" => 43.0,
               "fiber" => 43.0,
               "name" => "some updated name",
               "protein" => 43.0,
               "stock" => 43.0,
               "batch_price" => 3.2,
               "batch_weight" => 101.0,
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
