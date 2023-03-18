defmodule Zmeio.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Zmeio.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        first_name: "John",
        last_name: "Doe",
        email: "jd@gmail.com",
        password_hash: Bcrypt.hash_pwd_salt("pass"),
        provider: "local"
      })
      |> Zmeio.Identity.create_user()
    user
  end
end
