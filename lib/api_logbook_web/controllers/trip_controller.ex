defmodule ApiLogbookWeb.TripController do
  use ApiLogbookWeb, :controller

  alias ApiLogbook.Trips
  alias ApiLogbook.Trips.Trip

  action_fallback ApiLogbookWeb.FallbackController

  def index(conn, %{"car_id" => car_id}) do
    with {int, _} <- Integer.parse(car_id) do
      trips = Trips.list_trips(int)
    render(conn, "index.json", trips: trips)
    end
  end

  def create(conn, %{"trip" => trip_params}) do
    with {:ok, %Trip{} = trip} <- Trips.create_trip(trip_params) do
      conn
      |> put_status(:created)
      |> render("show.json", trip: trip)
    end
  end

  def show(conn, %{"id" => id}) do
    trip = Trips.get_trip!(id)
    render(conn, "show.json", trip: trip)
  end

  def update(conn, %{"id" => id, "trip" => trip_params}) do
    trip = Trips.get_trip!(id)

    with {:ok, %Trip{} = trip} <- Trips.update_trip(trip, trip_params) do
      render(conn, "show.json", trip: trip)
    end
  end

  def delete(conn, %{"id" => id}) do
    trip = Trips.get_trip!(id)

    with {:ok, %Trip{}} <- Trips.delete_trip(trip) do
      send_resp(conn, :no_content, "")
    end
  end
end
