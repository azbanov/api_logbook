defmodule ApiLogbookWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :api_logbook,
    module: ApiLogbookWeb.Auth.Guardian,
    error_handler: ApiLogbookWeb.Auth.ErrorHandler

    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource
end
