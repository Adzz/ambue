# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ambue,
  ecto_repos: [Ambue.Repo]

# Configures the endpoint
config :ambue, AmbueWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gksHWygheWvzgXheIuVRBz7R57e6O35oRCLE2EjxfaYsn0JGRR6jSQU/nRsDsdjn",
  render_errors: [view: AmbueWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Ambue.PubSub,
  live_view: [signing_salt: "wxGYL4Q9"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
