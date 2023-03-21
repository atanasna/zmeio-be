defmodule ZmeioWeb.AuthViewJSON do
  alias Zmeio.Identity.User

  def login(%{user: user, token: token}) do
    %{
      id: user.id,
      email: user.email,
      token: token
    }
  end

end
