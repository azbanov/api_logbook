defmodule ApiLogbookWeb.CarView do
  use ApiLogbookWeb, :view

  def render("car.json", %{car: car}) do
    %{
      objectId: car.objectId,
      manufacturer: car.manufacturer,
      model: car.model,
      category: car.category,
      year: car.year
    }
  end
end
