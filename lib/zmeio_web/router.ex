defmodule ZmeioWeb.Router do
  use ZmeioWeb, :router
  use Plug.ErrorHandler

  @impl Plug.ErrorHandler
  def handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(conn.status, Jason.encode!(%{errors: to_string(reason.message)}))
    |> halt()
  end

  #defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
  #  conn |> json(%{errors: message}) |> halt()
  #end

  #defp handle_errors(conn, %{reason: %{message: message}}) do
  #  conn |> json(%{errors: message}) |> halt()
  #end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug ZmeioWeb.Pipes.EnsureAuthentication
    plug ZmeioWeb.Plugs.LoadUser
  end

  scope "/api", ZmeioWeb do
    pipe_through :api
    get "/", DefaultController, :index

    post "/auth/login", AuthController, :login
    post "/auth/register", AuthController, :register
    post "/auth/login/:provider", AuthController, :oauth
  end

  scope "/api", ZmeioWeb do
    pipe_through [:api, :auth]

    get "/auth/logout", AuthController, :logout

    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    post "/users", UserController, :create
    put "/users/:id", UserController, :update
    put "/users/:id/reset_password", UserController, :reset_password
    delete "/users/:id", UserController, :delete

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
  end
end
