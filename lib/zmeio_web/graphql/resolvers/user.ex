defmodule ZmeioWeb.GraphQL.Resolvers.User do

  alias Zmeio.Identity.Auth
  
  def register(args, _context) do
    with {:ok, :auth, user} <- Auth.create_user_on_registeration(args.email, args.password, args.password_confirmation),
         {:ok, :auth, token} <- Auth.create_token(user)
    do
      {:ok, %{email: args.email, token: token, id: user.id}}
    else
      #{:error, :auth, %Ecto.Changeset{} = _changeset} -> {:error, message: "Registration failed!"}
      {:error, :auth, %Ecto.Changeset{} = changeset} -> {:error, GraphQL.Errors.extract(changeset)}
      _error -> raise ZmeioWeb.Exceptions.Generic.InternalServerError
    end
  end

  def login(args, _context) do
    with {:ok, :auth, user} <- Auth.get_user_on_valid_password(args.email, args.password),
         {:ok, :auth, token} <- Auth.create_token(user)
    do
      {:ok, %{email: args.email, token: token, id: user.id}}
    else
      {:error, :auth, :unauthenticated} -> raise ZmeioWeb.Exceptions.Auth.NotAuthenticated, message: "invalid email or password"
      _error -> raise ZmeioWeb.Exceptions.Generic.InternalServerError
    end
  end

  def login_with_oauth(_args, _context) do
    
  end

  def profile(_args, %{context: %{user: user}}) do
    case user do
      nil -> raise ZmeioWeb.Exceptions.Auth.NotAuthorized
      user -> {:ok, user}
    end
  end

  ###############################################
  # Admin
  ###############################################
  def show(args, context) do
    if not authorized?(args, context), do: raise ZmeioWeb.Exceptions.Auth.NotAuthorized

    {:ok, Zmeio.Identity.get_user!(args.id)}
  end

  def index(args, context) do
    if not authorized?(args, context), do: raise ZmeioWeb.Exceptions.Auth.NotAuthorized

    {:ok, Zmeio.Identity.list_users()}
  end

  defp authorized?(args, %{context: %{user: user}}) do
    cond do
      is_nil(user) -> false
      user.role == "admin" -> true
      user.id == Map.get(args, :id) -> true
      true -> false
    end
  end

end