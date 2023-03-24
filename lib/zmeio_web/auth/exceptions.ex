defmodule ZmeioWeb.Auth.Exceptions.NotAuthenticated do
  defexception [message: "not authenticated", plug_status: 401]
end

defmodule ZmeioWeb.Auth.Exceptions.NotAuthorized do
  defexception [message: "not auhotized", plug_status: 403]
end
