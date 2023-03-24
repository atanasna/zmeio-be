defmodule ZmeioWeb.Generic.Exceptions.InternalServerError do
  defexception [message: "something went wrong", plug_status: 500]
end

defmodule ZmeioWeb.Generic.Exceptions.NotFound do
  defexception [message: "resource not found", plug_status: 404]
end
