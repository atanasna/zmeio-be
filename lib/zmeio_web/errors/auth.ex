defmodule ZmeioWeb.Errors.Auth do
  import Plug.Conn

  def auth_error(conn, {type, reason}, _opts) do
    raise ZmeioWeb.Exceptions.Auth.NotAuthenticated#, message: reason
  end

end
