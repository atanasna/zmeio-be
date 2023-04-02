defmodule ZmeioWeb.GraphQL.Resolvers.Edible do

  import Ecto.Query, warn: false

  alias Zmeio.Identity.Auth
  alias ZmeioWeb.GraphQL.Auth
  
  def index(_args, _context) do
    {:ok, Zmeio.Store.Edible  |> Zmeio.Repo.all()}
  end
end