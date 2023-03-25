defmodule ZmeioWeb.Generic.Exceptions.InternalServerError do
  defexception [message: "something went wrong", plug_status: :internal_server_error]
end

defmodule ZmeioWeb.Generic.Exceptions.NotFound do
  defexception [message: "resource not found", plug_status: :not_found]
end


defmodule ZmeioWeb.Generic.Exceptions.WrongInput do
  defexception [message: "wrong inputs", plug_status: :unprocessable_entity]
end
