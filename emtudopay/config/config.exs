# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :emtudopay,
  ecto_repos: [Emtudopay.Repo]

# Configures the endpoint
config :emtudopay, EmtudopayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PMJ9cAN7SKtlyLm7fPBLzbGGRDWaozgF0nUbLM7hsBPuby6P4wWJWmSLtkoEbyhb",
  render_errors: [view: EmtudopayWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Emtudopay.PubSub,
  live_view: [signing_salt: "BLLh60A9"]

config :emtudopay, Emtudopay.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :emtudopay, :basic_auth,
  username: "banana",
  password: "nanica123"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
