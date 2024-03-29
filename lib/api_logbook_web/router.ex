defmodule ApiLogbookWeb.Router do
  use ApiLogbookWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ApiLogbookWeb.Auth.Pipeline
  end

  scope "/api", ApiLogbookWeb do
    pipe_through :api

    post "/register", UserController, :create
    post "/login", UserController, :signin
  end

  scope "/api", ApiLogbookWeb do
    # pipe_through [:api, :auth]
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit, :create]
    resources "/cars", CarController, only: [:create, :delete, :show]
    resources "/trips", TripController, except: [:new, :edit]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ApiLogbookWeb.Telemetry
    end
  end
end
