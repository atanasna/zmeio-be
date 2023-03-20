# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :zmeio,
  ecto_repos: [Zmeio.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :zmeio, ZmeioWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: ZmeioWeb.ErrorViewJSON],
    layout: false
  ],
  pubsub_server: Zmeio.PubSub,
  live_view: [signing_salt: "zbWSAH4s"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# GUARDIAN
#config :zmeio, ZmeioWeb.Auth.Guardian,
config :zmeio, ZmeioWeb.AuthKernel,
  issuer: "zmeio",
  secret_key: "rXuaLOOx4gN8GplJ1PzrZDuXmtEcWB/HQaZFSSVKEI7RVbbe7gpbBmGD9At8nM+R"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason


# Configure Google OAuth
#config :ueberauth, Ueberauth,
#  providers: [
#    google: {Ueberauth.Strategy.Google, [default_scope: "email profile plus.me"]}
#  ]
#
#config :ueberauth, Ueberauth.Strategy.Google.OAuth,
#  client_id: System.get_env("GOOGLE_CLIENT_ID"),
#  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
