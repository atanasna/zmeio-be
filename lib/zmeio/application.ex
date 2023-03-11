defmodule Zmeio.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ZmeioWeb.Telemetry,
      # Start the Ecto repository
      Zmeio.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Zmeio.PubSub},
      # Start the Endpoint (http/https)
      ZmeioWeb.Endpoint
      # Start a worker by calling: Zmeio.Worker.start_link(arg)
      # {Zmeio.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Zmeio.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ZmeioWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
