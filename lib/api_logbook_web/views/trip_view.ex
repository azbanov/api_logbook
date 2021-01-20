defmodule ApiLogbookWeb.TripView do
  use ApiLogbookWeb, :view
  alias ApiLogbookWeb.TripView

  def render("index.json", %{trips: trips}) do
    %{trips: render_many(trips, TripView, "trip.json")}
  end

  def render("show.json", %{trip: trip}) do
    %{trip: render_one(trip, TripView, "trip.json")}
  end

  def render("trip.json", %{trip: trip}) do
    %{
      id: trip.id,
      date: trip.date,
      place: trip.place,
      aim: trip.aim,
      business: trip.business,
      private: trip.private,
      consumption: trip.consumption,
      addition_expense: trip.addition_expense,
      notes: trip.notes
    }
  end
end
