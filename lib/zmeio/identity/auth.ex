defmodule Zmeio.Identity.Auth do
  alias Zmeio.Identity
  alias Zmeio.Identity.User
  alias Zmeio.Identity.Google

  @secret "kjoy3o1zeidquwy1398juxzldjlksahdk3"
  @salt "prasko"

  def create_token(%User{} = user) do
    {:ok, :auth, Phoenix.Token.sign(@secret, @salt, user.id)}
  end

  defp verify_token(token) do
    with {:ok, user_id} <- Phoenix.Token.verify(@secret, @salt, token, max_age: 86400) do
      {:ok, :auth, user_id}
    else
      _error -> {:error, :invalid_token}
    end
  end

  def get_user_on_valid_password(email, password) do
    case Identity.get_user_by_email(email) do
      {:ok, user} ->
        case Bcrypt.verify_pass(password, user.password_hash) do
          true -> {:ok, :auth, user}
          false ->  {:error, :auth, :unauthenticated}
        end
      {:error, :not_found} ->  {:error, :auth, :unauthenticated}
    end
  end

  def get_user_on_valid_token(token) do
    with {:ok, :auth, user_id} <- verify_token(token),
         user <- Identity.get_user!(user_id),
         false <- is_nil(user)
    do
      {:ok, :auth, user}
    else
      {:error, msg} -> {:error, :auth, :unauthenticated}
    end
  end

  def get_token_info_on_valid_oauth_id_token(id_token, provider) do
    case provider do
      "google" ->
        case Google.validate_id_token(id_token) do
          {:ok, token_info} -> {:ok, :auth, token_info}
          {:error, _} -> {:error, :auth, :unauthenticated}
        end
    end
  end

  def create_user_on_registeration(email, password, confirmation) do
    case Identity.create_user(%{"email" => email, "password" => password, "password_confirmation" => confirmation}) do
      {:ok, %User{} = user} -> {:ok, :auth, user}
      {:error, msg} -> {:error, :auth, msg}
    end
  end

  def get_or_create_user_from_oauth_token_info(token_info, provider) do
    email = token_info["email"]
    case Identity.get_user_by_email(email) do
      {:ok, user} -> {:ok, :auth, user}
      {:error, :not_found} ->
        case provider do
          "google" -> {:ok, :auth, Google.create_user_from_oauth_token_info(token_info)}
        end
    end

  end
end
