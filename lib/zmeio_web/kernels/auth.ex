defmodule ZmeioWeb.AuthKernel do
  use Guardian, otp_app: :zmeio

  alias Zmeio.Identity
  alias Zmeio.Identity.Google

  def subject_for_token(%{id: id}, _claims), do: {:ok, Kernel.to_string(id)}
  def subject_for_token(_,_), do: {:error, :no_id_provided}

  def resource_from_claims(%{"sub" => id}) do
    case Identity.get_user!(id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
  def resource_from_claims(_), do: {:error, :no_id_provided}

  def authenticate_user(email, password) do
    case Identity.get_user_by_email(email) do
      {:ok, nil} -> {:error, :unauthorized}
      {:ok, user} ->
        case Bcrypt.verify_pass(password, user.password_hash) do
          true -> create_token(user)
          false -> {:error, :unauthorized}
        end
    end
  end

  def authenticate_user(email) do
    case Identity.get_user_by_email(email) do
      {:ok, nil} -> {:error, :unauthorized}
      {:ok, user} -> create_token(user)
    end
  end

  def create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, user, token}
  end

  def validate_oauth_token(id_token, provider) do
    case provider do
      "google" -> Google.validate_id_token(id_token)
    end
  end

  def get_or_create_user_from_oauth_token_info(token_info, provider) do
    email = token_info["email"]
    case Identity.get_user_by_email(email) do
      {:ok, nil} ->
        case provider do
          "google" -> {:ok, Google.create_user_from_oauth_token_info(token_info)}
        end
      {:ok, user} -> {:ok, user}
      error -> error
    end

  end
end
