defmodule ZmeioWeb.Auth.Guardian do
  use Guardian, otp_app: :zmeio
  alias Zmeio.Identity

  def subject_for_token(%{id: id}, _claims), do: {:ok, Kernel.to_string(id)}
  def subject_for_token(_,_), do: {:error, :no_id_provided}

  def resource_from_claims(%{"sub" => id}) do
    case Zmeio.Identity.get_user!(id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
  def resource_from_claims(_), do: {:error, :no_id_provided}

  def authenticate(email, password) do
    case Identity.get_user_by_email(email) do
      nil -> {:error, :unauthorized}
      user ->
        case Bcrypt.verify_pass(password, user.password_hash) do
          true -> create_token(user)
          false -> {:error, :unauthorized}
        end
    end
  end

  def authenticate(email) do
    case Identity.get_user_by_email(email) do
      nil -> {:error, :unauthorized}
      user -> create_token(user)
    end
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, user, token}
  end

end
