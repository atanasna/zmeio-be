defmodule ZmeioWeb.Auth.Plugs.LoadUser do
  import Plug.Conn
  alias Zmeio.Identity

  def init(_opts) do
  end

  #def call(%{assigns: %{user: _user}} = conn, _opts), do: conn
  def call(%{assigns: %{user: _user}} = conn, _opts), do: conn
  def call(conn, _opts) do
    with user_id when not is_nil(user_id) <- Plug.Conn.get_session(conn, :user_id),
          user when not is_nil(user) <- Identity.get_user!(user_id)
    do
      Plug.Conn.assign(conn, :user, user)
    else
      _ -> Plug.Conn.assign(conn, :user, nil)
    end
  end
end
