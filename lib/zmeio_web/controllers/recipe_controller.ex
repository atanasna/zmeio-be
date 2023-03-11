defmodule ZmeioWeb.RecipeController do
  use ZmeioWeb, :controller

  alias Zmeio.Recipes
  alias Zmeio.Recipes.Recipe

  action_fallback ZmeioWeb.FallbackController

  def index(conn, _params) do
    recipe = Recipes.list()
    render(conn, :index, recipe: recipe)
  end

  def create(conn, %{"recipe" => recipe_params}) do
    with {:ok, %Recipe{} = recipe} <- Recipes.create(recipe_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/recipe/#{recipe}")
      |> render(:show, recipe: recipe)
    end
  end

  def show(conn, %{"id" => id}) do
    recipe = Recipes.get!(id)
    render(conn, :show, recipe: recipe)
  end

  def update(conn, %{"id" => id, "recipe" => recipe_params}) do
    recipe = Recipes.get!(id)

    with {:ok, %Recipe{} = recipe} <- Recipes.update(recipe, recipe_params) do
      render(conn, :show, recipe: recipe)
    end
  end

  def delete(conn, %{"id" => id}) do
    recipe = Recipes.get!(id)

    with {:ok, %Recipe{}} <- Recipes.delete(recipe) do
      send_resp(conn, :no_content, "")
    end
  end
end
