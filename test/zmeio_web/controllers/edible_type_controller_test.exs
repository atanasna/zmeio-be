defmodule ZmeioWeb.EdibleTypeControllerTest do
  use ZmeioWeb.ConnCase

  import Zmeio.EdibleTypesFixtures

  alias Zmeio.Store.EdibleType

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all edible_types", %{conn: conn} do
      conn = get(conn, ~p"/api/edible_types")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create edible_type" do
    test "renders edible_type when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/edible_types", edible_type: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/edible_types/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/edible_types", edible_type: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update edible_type" do
    setup [:create_edible_type]

    test "renders edible_type when data is valid", %{conn: conn, edible_type: %EdibleType{id: id} = edible_type} do
      conn = put(conn, ~p"/api/edible_types/#{edible_type}", edible_type: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/edible_types/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, edible_type: edible_type} do
      conn = put(conn, ~p"/api/edible_types/#{edible_type}", edible_type: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete edible_type" do
    setup [:create_edible_type]

    test "deletes chosen edible_type", %{conn: conn, edible_type: edible_type} do
      conn = delete(conn, ~p"/api/edible_types/#{edible_type}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/edible_types/#{edible_type}")
      end
    end
  end

  defp create_edible_type(_) do
    edible_type = edible_type_fixture()
    %{edible_type: edible_type}
  end
end
