defmodule ZmeioWeb.DefaultController do
  use ZmeioWeb, :controller

  def index(conn, _params) do
    text conn, "Zmeio is live - #{Mix.env()}"
  end
end
