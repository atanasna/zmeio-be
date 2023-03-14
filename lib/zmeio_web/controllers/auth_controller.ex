defmodule ZmeioWeb.AuthController do
  use ZmeioWeb, :controller
  #plug Ueberauth

  alias Zmeio.Identity.User

  def create(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{
      token: auth.credentials.token,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      email: auth.info.email,
      provider: "google"
    }

    changeset = User.changeset(%User{}, user_params)
  end
end
