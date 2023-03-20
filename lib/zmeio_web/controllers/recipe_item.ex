defmodule ZmeioWeb.RecipeItemController do
  use ZmeioWeb, :controller

  alias Zmeio.Store
  alias Zmeio.Store.RecipeItem

  action_fallback ZmeioWeb.FallbackController

  def index(conn, _params) do
    recipe_item = Store.list_recipe_items()
    render(conn, :index, recipe_item: recipe_item)
  end

  def create(conn, %{"recipe_item" => recipe_item_params}) do
    with {:ok, %RecipeItem{} = recipe_item} <- Store.create_recipe_item(recipe_item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/recipe_items/#{recipe_item}")
      |> render(:show, recipe_item: recipe_item)
    end
  end

  def show(conn, %{"id" => id}) do
    recipe_item = Store.get_recipe_item!(id)
    render(conn, :show, recipe_item: recipe_item)
  end

  def update(conn, %{"id" => id, "recipe_item" => recipe_item_params}) do
    recipe_item = Store.get_recipe_item!(id)

    with {:ok, %RecipeItem{} = recipe_item} <- Store.update_recipe_item(recipe_item, recipe_item_params) do
      render(conn, :show, recipe_item: recipe_item)
    end
  end

  def delete(conn, %{"id" => id}) do
    recipe_item = Store.get_recipe_item!(id)

    with {:ok, %RecipeItem{}} <- Store.delete_recipe_item(recipe_item) do
      send_resp(conn, :no_content, "")
    end
  end
end
