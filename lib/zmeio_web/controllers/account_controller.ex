defmodule ZmeioWeb.AccountController do
  use ZmeioWeb, :controller

  alias ZmeioWeb.Auth.{Guardian, Errors}
  alias Zmeio.Accounts
  alias Zmeio.Accounts.Account

  action_fallback ZmeioWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def signup(conn, %{} = params) do
    with {:ok, %Account{} = account} <- Accounts.create_account(params)
    do
      conn
      |> put_status(:created)
      |> render(:signup, account: account)
    end
  end

  def signin(conn, %{"email" => email, "password_hash" => password_hash}) do
    with {:ok, %Account{} = account, token} <- Guardian.authenticate(email,password_hash)
    do
      conn
      |> put_status(:ok)
      |> render(:signin, account: account, token: token)
    else
      {:error, :unauthorized} -> raise Errors.Unauthorized, message: "Incorrect email/password "
    end
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
