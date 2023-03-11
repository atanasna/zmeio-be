defmodule ZmeioWeb.EdibleCategoryControllerTest do
  use ZmeioWeb.ConnCase

  import Zmeio.EdibleCategoriesFixtures

  alias Zmeio.EdibleCategories.EdibleCategory

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
    test "lists all edible_categories", %{conn: conn} do
      conn = get(conn, ~p"/api/edible_categories")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create edible_category" do
    test "renders edible_category when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/edible_categories", edible_category: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/edible_categories/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/edible_categories", edible_category: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update edible_category" do
    setup [:create_edible_category]

    test "renders edible_category when data is valid", %{conn: conn, edible_category: %EdibleCategory{id: id} = edible_category} do
      conn = put(conn, ~p"/api/edible_categories/#{edible_category}", edible_category: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/edible_categories/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, edible_category: edible_category} do
      conn = put(conn, ~p"/api/edible_categories/#{edible_category}", edible_category: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete edible_category" do
    setup [:create_edible_category]

    test "deletes chosen edible_category", %{conn: conn, edible_category: edible_category} do
      conn = delete(conn, ~p"/api/edible_categories/#{edible_category}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/edible_categories/#{edible_category}")
      end
    end
  end

  defp create_edible_category(_) do
    edible_category = edible_category_fixture()
    %{edible_category: edible_category}
  end
end
