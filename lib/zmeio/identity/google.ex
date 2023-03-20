defmodule Zmeio.Identity.Google do
  alias Zmeio.Identity

  def validate_id_token(id_token) do
    token_info = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{id_token}"
    |> HTTPoison.get!
    |> Map.get(:body)
    |> Poison.decode!

    cond do
      token_info["aud"] != System.fetch_env!("GOOGLE_CLIENT_ID") -> {:error, "invalid client id"}
      token_info["email_verified"] != "true" -> {:error, "email not verified"}
      true -> {:ok, token_info}
    end
  end

  def create_user_from_oauth_token_info(token_info) do
    %{
      first_name: token_info["given_name"],
      last_name: token_info["family_name"],
      email: token_info["email"],
      password_hash: Bcrypt.hash_pwd_salt(Zmeio.Identity.User.generate_password()),
      provider: "google"
    }
    |> Identity.create_user()
  end
end
