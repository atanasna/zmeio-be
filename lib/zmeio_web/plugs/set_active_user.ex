defmodule ZmeioWeb.Plugs.LoadUser do
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

defmodule ZmeioWeb.Plugs.SetCurrentUser do
  import Plug.Conn

  alias Zmeio.Identity
  alias Zmeio.Identity.Auth

  def init(opts), do: opts

  def call(%{assigns: %{user: user}} = conn, _opts) when not is_nil(user), do: conn
  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, :auth, user} <- Auth.get_user_on_valid_token(token)
    do
      Plug.Conn.assign(conn, :user, user)
    else
      _error -> Plug.Conn.assign(conn, :user, nil)
    end
    #case get_user(conn) do
    #  nil -> conn
    #  user -> Absinthe.Plug.put_options(conn, context: %{current_user: user})
    #end
  end

  # private

  #defp get_user_on_valid_token(token) do
  #  with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
  #       {:ok, :auth, user_id} <- Auth.verify_token(token),
  #       user <- Identity.get_user!(user_id),
  #       false <- is_nil(user)
  #  do
  #    {:ok, user}
  #  else
  #    _error -> {:error, "invalid token"}
  #  end
  #end
  #defp get_user_from_session(conn) do
  #  with user_id <- Plug.Conn.get_session(conn, :user_id),
  #       user <- Identity.get_user!(user_id),
  #       false <- is_nil(user)
  #  do
  #    {:ok, user}
  #  else
  #    _error -> {:error, "no user in session"}
  #  end
  #end
end
