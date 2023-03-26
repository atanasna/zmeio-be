defmodule ZmeioWeb.Exceptions.Auth.NotAuthenticated do
  defexception [message: "not authenticated", plug_status: :unauthorized]
end

defmodule ZmeioWeb.Exceptions.Auth.NotAuthorized do
  defexception [message: "not authorized", plug_status: :forbidden]
end
