defmodule ZmeioWeb.UserController do
  use ZmeioWeb, :controller

  alias Zmeio.Identity
  alias Zmeio.Identity.User
  alias ZmeioWeb.ErrorViewJSON

  action_fallback ZmeioWeb.FallbackController

  plug :is_authorized when action in [:index, :show, :create, :update, :delete, :reset_password]

  #############################################
  # Plugs
  #############################################
  defp is_authorized(conn, _opts) do
    IO.inspect conn
    user = conn.assigns.user
    cond do
      is_nil(user) -> raise ZmeioWeb.Exceptions.Auth.NotAuthenticated
      user.role == "admin" -> conn
      user.id == conn.params["id"] -> conn
      true -> raise ZmeioWeb.Exceptions.Auth.NotAuthorized
    end
  end

  #############################################
  # Actions
  #############################################
  def index(conn, _params) do
    users = Identity.list_users()
    conn
    |> put_status(:ok)
    |> render(:index, users: users)
  end

  def create(conn, user_params) do
    with {:ok, %User{} = user} <- Identity.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Identity.get_user!(id)
    conn
    |> put_status(:ok)
    |> render(:show, user: user)
  end

  def update(conn, params) do
    user = Identity.get_user!(params["id"])
    with {:ok, %User{} = user} <- Identity.update_user(user, params) do
      conn
      |> put_status(:ok)
      |> render(:show, user: user)
    end
  end

  def reset_password(conn, %{"id" => id, "password" => password, "password_confirmation" => confirmation} = params) do
    user = Identity.get_user!(id)
    with {:ok, %User{} = user} <- Identity.reset_user_password(user, params) do
      conn
      |> put_status(:ok)
      |> render(:show, user: user)
    end
  end
  def reset_password(conn, _), do: raise ZmeioWeb.Exceptions.Generic.WrongInput, message: "request should contain id, password and password_confirmation"

  def delete(conn, %{"id" => id}) do
    user = Identity.get_user!(id)

    with {:ok, %User{}} <- Identity.delete_user(user) do
      conn
      |> put_status(:ok)
      |> send_resp(:no_content, "")
    end
  end


end
