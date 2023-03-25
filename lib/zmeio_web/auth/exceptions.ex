defmodule ZmeioWeb.Auth.Exceptions.NotAuthenticated do
  defexception [message: "not authenticated", plug_status: :unauthorized]
end

defmodule ZmeioWeb.Auth.Exceptions.NotAuthorized do
  defexception [message: "not authorized", plug_status: :forbidden]
end
