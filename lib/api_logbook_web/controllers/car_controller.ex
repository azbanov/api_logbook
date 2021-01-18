defmodule ApiLogbookWeb.CarController do
  use ApiLogbookWeb, :controller

  alias ApiLogbook.Accounts
  alias ApiLogbook.Accounts.Car

  action_fallback ApiLogbookWeb.FallbackController

  def create(conn, %{"car" => car_params}) do
    with {:ok, %Car{} = car} <- Accounts.create_car(car_params) do
      conn
      |> put_status(:created)
      |> render("show.json", %{car: car})
    end
  end

  def show(conn, %{"id" => id}) do
    render conn, "show.json", %{car: Accounts.get_car!(id)}
  end
end
