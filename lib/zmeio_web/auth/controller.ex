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
      |> put_status(200)
      |> put_view(AuthViewJSON)
      |> render(:login, %{user: user, token: token})
    else
      {:error, :auth, :unauthorized} ->
        conn
        |> put_status(401)
        |> put_view(ErrorViewJSON)
        |> render(:generic, %{message: "Invalid Oauth Information"})
      _any_other_error -> {:error, :internal_error} # Handled by the fallback controller
    end
  end

  #################################################################
  # Local Login
  #################################################################
  def login(conn, login_params) do
    with {:ok, :auth, user} <- AuthKernel.validate_password(login_params["email"], login_params["password"]),
         {:ok, :auth, token} <- AuthKernel.authenticate_user(login_params["email"])
    do
      conn
      |> put_status(200)
      |> put_view(AuthViewJSON)
      |> render(:login, %{user: user, token: token})
    else
      {:error, :auth, :unauthorized} ->
        conn
        |> put_status(:unauthorized)
        |> put_view(ErrorViewJSON)
        |> render(:generic, %{message: "Invalid Email or Password"})
      _any_other_error -> {:error, :internal_error} # Handled by the fallback controller
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
      |> put_status(:created)
      |> put_view(AuthViewJSON)
      |> render(:login, %{user: user, token: token})
    else
      {:error, :auth, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(422)
        |> put_view(ErrorViewJSON)
        |> render(:ecto, %{changeset: changeset})
      _any_other_error -> {:error, :internal_error} # Handled by the fallback controller
    end
  end
end
