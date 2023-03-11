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
        full_name: "some full_name"
      })
      |> Zmeio.Users.create_user()

    user
  end
end
