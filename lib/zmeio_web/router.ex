defmodule ZmeioWeb.Router do
  use ZmeioWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ZmeioWeb do
    pipe_through :api
    get "/", DefaultController, :index
  end
end
