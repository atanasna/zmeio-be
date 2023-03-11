import Config

config :zmeio, Zmeio.Repo,
  username: "admin",
  password: "admin",
  hostname: "localhost",
  database: "zmeio_prod",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For production, don't forget to configure the url host
# to something meaningful, Phoenix uses this information
# when generating URLs.

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
