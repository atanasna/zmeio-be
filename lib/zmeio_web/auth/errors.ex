defmodule ZmeioWeb.Auth.Errors do
  import Plug.Conn

  def auth_error(conn, {type, reason}, _opts) do
    raise ZmeioWeb.Auth.Exceptions.NotAuthenticated#, message: reason
  end

end
