# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :api_logbook,
  ecto_repos: [ApiLogbook.Repo]

# Configures the endpoint
config :api_logbook, ApiLogbookWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Wbh/pb9j1obl7hgPus9nsGQhk21SFCDA9gPuCacfKaNNcy3jKMLgCmoVBvzLeft4",
  render_errors: [view: ApiLogbookWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ApiLogbook.PubSub,
  live_view: [signing_salt: "8dG/yM6j"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
