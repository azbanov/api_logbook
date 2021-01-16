defmodule ApiLogbookWeb.CarView do
  use ApiLogbookWeb, :view

  alias ApiLogbookWeb.TripView

  def render("car.json", %{car: car}) do
    %{
      id: car.id,
      objectId: car.objectId,
      manufacturer: car.manufacturer,
      model: car.model,
      category: car.category,
      year: car.year,
      trips: render_many(car.trips, TripView, "trip.json")
    }
  end
end
