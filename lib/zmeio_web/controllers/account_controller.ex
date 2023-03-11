defmodule ZmeioWeb.AccountController do
  use ZmeioWeb, :controller

  alias Zmeio.Accounts
  alias Zmeio.Accounts.Account

  action_fallback ZmeioWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
      #{:ok, %User{} = user} <- Users.create_user(account_params),
      {:ok, token, _claims} <- ZmeioWeb.Auth.Guardian.encode_and_sign(account)
    do
      conn
      |> put_status(:created)
      |> render(:show, account: account)
    end
  end

  def login(conn) do
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{} = account} <- Accounts.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
