# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Configures the dev endpoint
config :rayyan_site, RayyanSiteWeb.Endpoint,
  render_errors: [view: RayyanSiteWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: RayyanSite.PubSub,
  live_view: [signing_salt: "21z6R2jI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Use TzData for time zone db
config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

# You can change the iex prompt
config :iex, default_prompt: ">>>"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
