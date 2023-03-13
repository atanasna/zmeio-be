defmodule ZmeioWeb.AccountJSON do
  alias Zmeio.Accounts.Account

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    %{data: data(account)}
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      email: account.email,
      password_hash: account.password_hash
    }
  end

  def signup(%{account: account}) do
    %{
      id: account.id,
      email: account.email
    }
  end

  def signin(%{account: account, token: token}) do
    %{
      id: account.id,
      email: account.email,
      token: token
    }
  end
end
