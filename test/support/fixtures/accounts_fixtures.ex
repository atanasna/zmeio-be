defmodule Zmeio.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Zmeio.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        email: "some email",
        password_hash: "some password_hash"
      })
      |> Zmeio.Accounts.create_account()

    account
  end
end
