# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :shop,
  ecto_repos: [Shop.Repo]

# Configures the endpoint
config :shop, ShopWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RnZyTq3VDYhmF3WpZB9GH41pdu0GxhefCg2OfRhTdLnwpJwxuzDQb3GrmznCaWXa",
  render_errors: [view: ShopWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Shop.PubSub,
  live_view: [signing_salt: "kX+/jYLX"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
