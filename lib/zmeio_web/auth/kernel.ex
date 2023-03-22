defmodule ZmeioWeb.AuthKernel do
  use Guardian, otp_app: :zmeio

  alias Zmeio.Identity
  alias Zmeio.Identity.User
  alias Zmeio.Identity.Google

  def subject_for_token(%{id: id}, _claims), do: {:ok, Kernel.to_string(id)}
  def subject_for_token(_,_), do: {:error, :no_id_provided}

  def resource_from_claims(%{"sub" => id}) do
    case Identity.get_user!(id) do
      nil ->  {:error, :auth, :not_found}
      user -> {:ok, user}
    end
  end

  def resource_from_claims(_), do: {:error, :auth, :no_id_provided}

  #def authenticate_user(email, password) do
  #  case Identity.get_user_by_email(email) do
  #    {:ok, nil} -> {:error, :unauthorized}
  #    {:ok, user} ->
  #      case Bcrypt.verify_pass(password, user.password_hash) do
  #        true -> create_token(user)
  #        false -> {:error, :unauthorized}
  #      end
  #  end
  #end

  def authenticate_user(email) do
    case Identity.get_user_by_email(email) do
      {:ok, user} ->
        {:ok, token, _claims} = encode_and_sign(user)
        {:ok, :auth, token}
      {:error, :not_found} -> {:error, :auth, :unauthorized}
    end
  end

  def validate_password(email, password) do
    case Identity.get_user_by_email(email) do
      {:ok, user} ->
        case Bcrypt.verify_pass(password, user.password_hash) do
          true -> {:ok, :auth, user}
          false ->  {:error, :auth, :unauthorized}
        end
      {:error, :not_found} ->  {:error, :auth, :unauthorized}
    end
  end

  def validate_oauth_token(id_token, provider) do
    case provider do
      "google" ->
        case Google.validate_id_token(id_token) do
          {:ok, token_info} -> {:ok, :auth, token_info}
          {:error, _} -> {:error, :auth, :unauthorized}
        end
    end
  end

  def create_user_from_register_params(params) do
    case Identity.create_user(params) do
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
