defmodule ZmeioWeb.AuthController do
  use ZmeioWeb, :controller

  alias Zmeio.Identity
  alias Zmeio.Identity.User
  alias ZmeioWeb.AuthKernel
  alias ZmeioWeb.AuthViewJSON
  alias ZmeioWeb.ErrorsViewJSON

  #################################################################
  # Oauth Login/Register
  #################################################################
  def oauth(conn, %{"id_token" => id_token} = params) do
    with {:ok, token_info} <- AuthKernel.validate_oauth_token(id_token, params["provider"]),
         {:ok, user} <- AuthKernel.get_or_create_user_from_oauth_token_info(token_info, params["provider"]),
         {:ok, user, token} <- AuthKernel.authenticate_user(token_info["email"]) do
      conn
      |> put_status(200)
      |> put_view(AuthViewJSON)
      |> render(:show, user: Map.put(user, :token, token))
    else
      {:error, :oauth, msg} ->
        conn
        |> put_status(401)
        |> put_view(ErrorsViewJSON)
        |> render(:generic, %{message: "invalid oauth authentication: #{msg}"})
    end
  end

  #################################################################
  # Local Login
  #################################################################
  def login(conn, params) do
    with {:ok, user, token} <- AuthKernel.authenticate_user(params["email"], params["password"]) do
      conn
      |> put_status(200)
      |> put_view(AuthViewJSON)
      |> render(:show, user: Map.put(user, :token, token))
    else
      {:error, :unauthorized} ->
        conn
        |> put_status(:unauthorized)
        |> put_view(ErrorsViewJSON)
        |> render(:generic, %{message: "email or password is wrong"})
      {:error, _} ->
        conn
        |> put_status(500)
        |> put_view(ErrorsViewJSON)
        |> render(:generic, %{message: "something went wrong"})
    end
  end

  #################################################################
  # Local Register
  #################################################################
  def register(conn, params) do
    user_params = params
    |> Map.put("password_hash", Bcrypt.hash_pwd_salt(params["password"]))
    |> Map.put("provider", "local")

    with {:ok, %User{} = user} <- Identity.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_view(AuthViewJSON)
      |> render(:show, user: user)
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(422)
        |> put_view(ErrorsViewJSON)
        |> render(:ecto, %{changeset: changeset})
      {:error, _} ->
        conn
        |> put_status(500)
        |> put_view(ErrorsViewJSON)
        |> render(:generic, %{message: "something went wrong"})
    end
  end
end
