# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :facebook_app,
  ecto_repos: [FacebookApp.Repo]

# Configures the endpoint
config :facebook_app, FacebookAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FaZPEMJsgOYmOEpUELpubOn0zrf3yBx9HubJupCcysgT4WiRXXFT308OPft0QMZP",
  render_errors: [view: FacebookAppWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: FacebookApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :facebook_app, FacebookAppWeb.Helpers.Plugs.Guardian,
  issuer: "facebook_app",
  secret_key: "yY41GR16m+gxixd+3/6RruhwUocGywlx5ncDaCWK8aRbWvTzhhSv429jma6rmnST"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
