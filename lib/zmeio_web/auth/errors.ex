defmodule ZmeioWeb.Auth.Errors.Generic do
  defexception [message: "Something went wrong", plug_status: 401]
end

defmodule ZmeioWeb.Auth.Errors.Unauthorized do
  defexception [message: "Unauthorized", plug_status: 401]
end

defmodule ZmeioWeb.Auth.Errors.InvalidGoogleOauth do
  defexception [message: "Google Oauth failed ", plug_status: 401]
end


defmodule ZmeioWeb.Auth.Errors.WrongParameters do
  defexception [message: "WrongParameters", plug_status: 401]
end
