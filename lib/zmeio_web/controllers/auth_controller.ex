defmodule ZmeioWeb.AuthController do
  use ZmeioWeb, :controller
  #plug Ueberauth

  alias Zmeio.Identity
  alias Zmeio.Identity.User
  alias ZmeioWeb.Auth.Guardian

  def oauth(conn, %{"provider" => "google", "id_token" => id_token} = params) do
    body = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{id_token}"
    |> HTTPoison.get!
    |> Map.get(:body)
    |> Poison.decode!

    if body["aud"] != System.fetch_env!("GOOGLE_CLIENT_ID"), do: raise ZmeioWeb.Auth.Errors.InvalidGoogleOauth
    if body["email_verified"] != "true", do: raise ZmeioWeb.Auth.Errors.InvalidGoogleOauth

    IO.inspect(Identity.get_user_by_email(body["email"]))
    if Identity.get_user_by_email(body["email"]) == nil do
      user_params = %{
        first_name: body["given_name"],
        last_name: body["family_name"],
        email: body["email"],
        password_hash: Bcrypt.hash_pwd_salt("iuahd872dasd1"),
        provider: params["provider"]
      }
      {:ok, %User{} = user} = Identity.create_user(user_params)
    end

    {:ok, user, token} = Guardian.authenticate(body["email"])
    render(conn, :show, user: Map.put(user, :token, token))
  end

  def oauth(conn, %{"provider" => "facebook", "id_token" => id_token} = params) do
    conn
    |> redirect(to: "/facebook")
  end

  def login(conn, params) do
    with {:ok, user, token} <- Guardian.authenticate(params["email"], params["password"]) do
      render(conn, :show, user: Map.put(user, :token, token))
    else
      {:error, :unauthorized} -> raise ZmeioWeb.Auth.Errors.Unauthorized, message: "email or password is wrong"
      {:error, _} -> raise ZmeioWeb.Auth.Errors.Generic, message: "something went wrong"
    end
  end

  def register(conn, params) do
    user_params = params
    |> Map.put("password_hash", Bcrypt.hash_pwd_salt(params["password"]))
    |> Map.put("provider", "local")

    with {:ok, %User{} = user} <- Identity.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    else
      {:error, %Ecto.Changeset{} = cs} -> conn |> put_status(422) |> render(ZmeioWeb.ErrorJSON, :ecto, %{changeset: cs})
      {:error, _} -> conn |> put_status(500) |> render(ZmeioWeb.ErrorJSON, :generic, %{message: "Something went wrong"})
    end
  end

end
