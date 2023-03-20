defmodule ZmeioWeb.FallbackController do

  alias ZmeioWeb.ErrorViewJSON

  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ZmeioWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: ZmeioWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ZmeioWeb.ErrorViewJSON)
    #|> put_view(html: ZmeioWeb.ErrorHTML, json: )
    |> render(:generic, %{message: "Resource Not Found"})
  end

  # Auth Errors
  def call(conn, {:error, :internal_error}) do
    conn
    |> put_status(500)
    |> put_view(ZmeioWeb.ErrorViewJSON)
    |> render(:generic, %{message: "Internal Server Error"})
  end

end
