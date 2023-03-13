defmodule ZmeioWeb.Auth.Errors.Unauthorized do
  defexception [message: "Unauthorized", plug_status: 401]
end
