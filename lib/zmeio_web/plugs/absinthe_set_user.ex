defmodule ZmeioWeb.Plugs.SetUser do
  import Plug.Conn

  alias Zmeio.Identity
  alias Zmeio.Identity.Auth

  def init(opts), do: opts

  #def call(%{assigns: %{user: user}} = conn, _opts) when not is_nil(user), do: conn
  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, :auth, user} <- Auth.get_user_on_valid_token(token)
    do
      #Plug.Conn.assign(conn, :user, user)
      Absinthe.Plug.put_options(conn, context: %{user: user})
    else
      _error -> 
        #Plug.Conn.assign(conn, :user, nil)
        Absinthe.Plug.put_options(conn, context: %{user: nil})
    end
  end
end