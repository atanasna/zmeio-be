defmodule ZmeioWeb.RecipeItemControllerTest do
  use ZmeioWeb.ConnCase

  import Zmeio.RecipeItemsFixtures

  alias Zmeio.Store.RecipeItem

  @create_attrs %{
    batches: 42
  }
  @update_attrs %{
    batches: 43
  }
  @invalid_attrs %{batches: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all recipe_item", %{conn: conn} do
      conn = get(conn, ~p"/api/recipe_items")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create recipe_item" do
    test "renders recipe_item when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/recipe_items", recipe_item: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/recipe_items/#{id}")

      assert %{
               "id" => ^id,
               "batches" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/recipe_items", recipe_item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update recipe_item" do
    setup [:create_recipe_item]

    test "renders recipe_item when data is valid", %{conn: conn, recipe_item: %RecipeItem{id: id} = recipe_item} do
      conn = put(conn, ~p"/api/recipe_items/#{recipe_item}", recipe_item: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/recipe_items/#{id}")

      assert %{
               "id" => ^id,
               "batches" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, recipe_item: recipe_item} do
      conn = put(conn, ~p"/api/recipe_items/#{recipe_item}", recipe_item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete recipe_item" do
    setup [:create_recipe_item]

    test "deletes chosen recipe_item", %{conn: conn, recipe_item: recipe_item} do
      conn = delete(conn, ~p"/api/recipe_items/#{recipe_item}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/recipe_items/#{recipe_item}")
      end
    end
  end

  defp create_recipe_item(_) do
    recipe_item = recipe_item_fixture()
    %{recipe_item: recipe_item}
  end
end
