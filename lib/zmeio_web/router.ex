defmodule ZmeioWeb.Router do
  use ZmeioWeb, :router
  use Plug.ErrorHandler

  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  defp handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth", ZmeioWeb do
    #pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :create
  end

  scope "/api", ZmeioWeb do
    pipe_through :api
    get "/", DefaultController, :index
    #post "/auth/signup", AccountController, :signup
    #post "/auth/signin", AccountController, :signin

    get "/edibles", EdibleController, :index
    get "/edibles/:id", EdibleController, :show
    post "/edibles", EdibleController, :create
    put "/edibles/:id", EdibleController, :update
    delete "/edibles/:id", EdibleController, :delete

    get "/edible_types", EdibleTypeController, :index
    get "/edible_types/:id", EdibleTypeController, :show
    post "/edible_types", EdibleTypeController, :create
    put "/edible_types/:id", EdibleTypeController, :update
    delete "/edible_types/:id", EdibleTypeController, :delete

    get "/orders", OrderController, :index
    get "/orders/:id", OrderController, :show
    post "/orders", OrderController, :create
    put "/orders/:id", OrderController, :update
    delete "/orders/:id", OrderController, :delete

    resources "/order_items", OrderItemController, except: [:edit, :new]
    resources "/recipes", RecipeController, except: [:edit, :new]
    resources "/recipe_items", RecipeItemController, except: [:edit, :new]
    #post "/auth/signin", AccountController, :signin
    #post "/auth/signin", AccountController, :signin
  end
end
