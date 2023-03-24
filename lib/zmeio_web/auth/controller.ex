defmodule ZmeioWeb.AuthController do
  use ZmeioWeb, :controller

  action_fallback ZmeioWeb.FallbackController

  alias Zmeio.Identity
  alias Zmeio.Identity.User
  alias ZmeioWeb.AuthKernel
  alias ZmeioWeb.AuthViewJSON
  alias ZmeioWeb.ErrorViewJSON

  #################################################################
  # Oauth Login/Register
  #################################################################
  def oauth(conn, %{"id_token" => id_token} = oauth_params) do
    with {:ok, :auth, token_info} <- AuthKernel.validate_oauth_token(id_token, oauth_params["provider"]),
         {:ok, :auth, user} <- AuthKernel.get_or_create_user_from_oauth_token_info(token_info, oauth_params["provider"]),
         {:ok, :auth, token} <- AuthKernel.authenticate_user(token_info["email"])
    do
      conn
      |> Plug.Conn.put_session(:user_id, user.id)
      |> put_status(200)
      |> put_view(AuthViewJSON)
      |> render(:login, %{user: user, token: token})
    else
      {:error, :auth, :unauthenticated} ->
        raise ZmeioWeb.Auth.Exceptions.NotAuthenticated, message: "Invalid Oauth Information"
      _error ->
        raise ZmeioWeb.Generic.Exceptions.InternalServerError
    end
  end

  #################################################################
  # Local Login
  #################################################################
  def login(conn, login_params) do
    with {:ok, :auth, user} <- AuthKernel.get_user_on_valid_password(login_params["email"], login_params["password"]),
         {:ok, :auth, token} <- AuthKernel.authenticate_user(login_params["email"])
    do
      conn
      |> Plug.Conn.put_session(:user_id, user.id) #represented as cookie in browser
      |> put_status(200)
      |> put_view(AuthViewJSON)
      |> render(:login, %{user: user, token: token})
    else
      {:error, :auth, :unauthenticated} ->
        raise ZmeioWeb.Auth.Exceptions.NotAuthenticated, message: "Invalid Email or Password"
      _error ->
        raise ZmeioWeb.Generic.Exceptions.InternalServerError
    end
  end

  #################################################################
  # Local Register
  #################################################################
  def register(conn, register_params) do
    user_params = register_params |> Map.put("provider", "local")

    with {:ok, :auth, user} <- AuthKernel.create_user_from_register_params(user_params),
         {:ok, :auth, token} <- AuthKernel.authenticate_user(user_params["email"])
    do
      conn
      |> Plug.Conn.put_session(:user_id, user.id)
      |> put_status(:created)
      |> put_view(AuthViewJSON)
      |> render(:login, %{user: user, token: token})
    else
      {:error, :auth, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(422)
        |> put_view(ErrorViewJSON)
        |> render(:ecto, %{changeset: changeset})
      _error ->
        raise ZmeioWeb.Generic.Exceptions.InternalServerError
    end
  end
end
