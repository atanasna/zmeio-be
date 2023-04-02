defmodule ZmeioWeb.GraphQL.Auth do
 
  def authenticated?(_args, %{context: %{user: user}}) do
    case user do
      nil -> {:ok, false}
      _ -> {:ok, true, user}
    end
  end

end