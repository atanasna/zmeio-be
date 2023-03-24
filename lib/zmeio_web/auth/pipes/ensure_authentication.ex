defmodule ZmeioWeb.Auth.Pipelines.EnsureAuthentication do
  use Guardian.Plug.Pipeline, otp_app: :zmeio,
  module: ZmeioWeb.AuthKernel,
  error_handler: ZmeioWeb.Auth.Pipelines.ErrorHandler

  # If there is a session token, validate it
  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  # If there is an authorization header, validate it
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  # Load the user if either of the verifications worked
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource#, allow_blank: true

end

defmodule ZmeioWeb.Auth.Pipelines.ErrorHandler do
  import Plug.Conn

  def auth_error(conn, {type, reason}, _opts) do
    #body = Jason.encode!(%{error: to_string(type)})
#
    #conn
    #|> put_resp_content_type("application/json")
    #|> send_resp(401, body)
    raise ZmeioWeb.Auth.Exceptions.NotAuthenticated
  end

end
