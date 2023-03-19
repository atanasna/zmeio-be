defmodule ZmeioWeb.AuthViewJSON do
  alias Zmeio.Identity.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{status: :ok, users: for(user <- users, do: data(user))}
    #%{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    data(user)
  end

  def error(%{changeset: changeset}) do
    %{errors: JaSerializer.EctoErrorSerializer.format(changeset)["errors"]}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      token: user.token,
      provider: user.provider,
      avatar: user.avatar,
    }
  end
end
