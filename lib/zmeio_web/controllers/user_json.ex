defmodule ZmeioWeb.UserJSON do
  alias Zmeio.Identity.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    for(user <- users, do: data(user))
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    data(user)
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      rold: user.role,
      #token: user.token,
      provider: user.provider,
      avatar: user.avatar,
    }
  end
end
