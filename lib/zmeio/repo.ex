defmodule Zmeio.Repo do
  use Ecto.Repo,
    otp_app: :zmeio,
    adapter: Ecto.Adapters.Postgres
end
