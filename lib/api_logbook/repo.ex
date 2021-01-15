defmodule ApiLogbook.Repo do
  use Ecto.Repo,
    otp_app: :api_logbook,
    adapter: Ecto.Adapters.Postgres
end
