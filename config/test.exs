use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ambue, Ambue.Repo,
  username: "postgres",
  password: "hunter_42",
  database: "ambue_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  port: 54321,
  timeout: 9999,
  # Super long timeout to avoid interrupting pry sessions
  ownership_timeout: 999_999_999,
  # see here https://hexdocs.pm/db_connection/DBConnection.html#start_link/2-queue-config
  queue_target: 5_000,
  queue_interval: 10_000

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ambue, AmbueWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
