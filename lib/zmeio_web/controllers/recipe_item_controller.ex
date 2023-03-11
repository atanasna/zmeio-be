defmodule ZmeioWeb.RecipeItemController do
  use ZmeioWeb, :controller

  alias Zmeio.RecipeItems
  alias Zmeio.RecipeItems.RecipeItem

  action_fallback ZmeioWeb.FallbackController

  def index(conn, _params) do
    recipe_item = RecipeItems.list()
    render(conn, :index, recipe_item: recipe_item)
  end

  def create(conn, %{"recipe_item" => recipe_item_params}) do
    with {:ok, %RecipeItem{} = recipe_item} <- RecipeItems.create(recipe_item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/recipe_item/#{recipe_item}")
      |> render(:show, recipe_item: recipe_item)
    end
  end

  def show(conn, %{"id" => id}) do
    recipe_item = RecipeItems.get!(id)
    render(conn, :show, recipe_item: recipe_item)
  end

  def update(conn, %{"id" => id, "recipe_item" => recipe_item_params}) do
    recipe_item = RecipeItems.get!(id)

    with {:ok, %RecipeItem{} = recipe_item} <- RecipeItems.update(recipe_item, recipe_item_params) do
      render(conn, :show, recipe_item: recipe_item)
    end
  end

  def delete(conn, %{"id" => id}) do
    recipe_item = RecipeItems.get!(id)

    with {:ok, %RecipeItem{}} <- RecipeItems.delete(recipe_item) do
      send_resp(conn, :no_content, "")
    end
  end
end
