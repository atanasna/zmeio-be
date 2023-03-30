defmodule ZmeioWeb.AuthController do
  use ZmeioWeb, :controller

  action_fallback ZmeioWeb.FallbackController

  #alias Zmeio.Identity
  #alias Zmeio.Identity.User
  alias Zmeio.Identity.Auth
  alias ZmeioWeb.AuthViewJSON
  alias ZmeioWeb.ErrorViewJSON

  #################################################################
  # Oauth Login/Register
  #################################################################
  def oauth(conn, %{"id_token" => id_token, "provider" => provider}) do
    with {:ok, :auth, token_info} <- Auth.get_token_info_on_valid_oauth_id_token(id_token, provider),
         {:ok, :auth, user} <- Auth.get_or_create_user_from_oauth_token_info(token_info, provider),
         {:ok, :auth, token} <- Auth.create_token(user)
    do
      conn
      #|> Plug.Conn.put_session(:user_id, user.id)
      |> put_status(200)
      |> put_view(AuthViewJSON)
      |> render(:login, %{user: user, token: token})
    else
      {:error, :auth, :unauthenticated} ->
        raise ZmeioWeb.Exceptions.Auth.NotAuthenticated, message: "invalid oauth information"
      _error ->
        raise ZmeioWeb.Exceptions.Generic.InternalServerError
    end
  end
  def oauth(_conn, _), do: raise ZmeioWeb.Exceptions.Generic.WrongInput, message: "request should contain id_token and provider"

  #################################################################
  # Register
  #################################################################
  def register(conn, %{"email" => email, "password" => password, "password_confirmation" => confirmation}) do
    with {:ok, :auth, user} <- Auth.create_user_on_registeration(email, password, confirmation),
         {:ok, :auth, token} <- Auth.create_token(user)
    do
      conn
      #|> Plug.Conn.put_session(:user_id, user.id)
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
        raise ZmeioWeb.Exceptions.Generic.InternalServerError
    end
  end
  def register(_conn, _), do: raise ZmeioWeb.Exceptions.Generic.WrongInput, message: "request should contain email, password and password_confirmation"

  #################################################################
  # Login
  #################################################################
  def login(conn, %{"email" => email, "password" => password}) do
    with {:ok, :auth, user} <- Auth.get_user_on_valid_password(email, password),
         {:ok, :auth, token} <- Auth.create_token(user)
    do
      conn
      #|> Plug.Conn.put_session(:user_id, user.id) #represented as cookie in browser
      |> put_status(200)
      |> put_view(AuthViewJSON)
      |> render(:login, %{user: user, token: token})
    else
      {:error, :auth, :unauthenticated} ->
        raise ZmeioWeb.Exceptions.Auth.NotAuthenticated, message: "invalid email or password"
      _error ->
        raise ZmeioWeb.Exceptions.Generic.InternalServerError
    end
  end
  def login(_conn, _), do: raise ZmeioWeb.Exceptions.Generic.WrongInput, message: "request should contain email and password"

  #################################################################
  # Logout
  #################################################################
  def logout(conn, %{}) do
    conn
    #|> Plug.Conn.delete_session(:user_id)
    |> put_status(200)
    |> put_view(AuthViewJSON)
    |> render(:logout)
  end

end
