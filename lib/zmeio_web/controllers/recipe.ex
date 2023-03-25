defmodule ZmeioWeb.RecipeController do
  use ZmeioWeb, :controller

  alias Zmeio.Store
  alias Zmeio.Store.Recipe

  action_fallback ZmeioWeb.FallbackController

  #def public(conn, _params) do
  #  recipe = Store.list_public_recipes()
  #  render(conn, :index, recipe: recipe)
  #end

  def index(conn, _params) do
    recipe = Store.list_recipes()
    render(conn, :index, recipe: recipe)
  end

  def create(conn, %{"recipe" => recipe_params}) do
    with {:ok, %Recipe{} = recipe} <- Store.create_recipe(recipe_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/recipes/#{recipe}")
      |> render(:show, recipe: recipe)
    end
  end

  def show(conn, %{"id" => id}) do
    recipe = Store.get_recipe!(id)
    render(conn, :show, recipe: recipe)
  end

  def update(conn, %{"id" => id, "recipe" => recipe_params}) do
    recipe = Store.get_recipe!(id)

    with {:ok, %Recipe{} = recipe} <- Store.update_recipe(recipe, recipe_params) do
      render(conn, :show, recipe: recipe)
    end
  end

  def delete(conn, %{"id" => id}) do
    recipe = Store.get_recipe!(id)

    with {:ok, %Recipe{}} <- Store.delete_recipe(recipe) do
      send_resp(conn, :no_content, "")
    end
  end
end
