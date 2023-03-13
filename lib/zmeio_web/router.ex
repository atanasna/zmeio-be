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

  scope "/api", ZmeioWeb do
    pipe_through :api
    get "/", DefaultController, :index
    post "/auth/signup", AccountController, :signup
    post "/auth/signin", AccountController, :signin

    get "/edibles", EdibleController, :index
    get "/edibles/:id", EdibleController, :show
    post "/edibles", EdibleController, :create
    #get "/edibles", EdibleController, :index
    put "/edibles/:id", EdibleController, :update
    delete "/edibles/:id", EdibleController, :delete
    #post "/auth/signin", AccountController, :signin
    #post "/auth/signin", AccountController, :signin
  end
end
