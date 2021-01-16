defmodule ApiLogbookWeb.UserView do
  use ApiLogbookWeb, :view

  alias ApiLogbookWeb.CarView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, ApiLogbookWeb.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, ApiLogbookWeb.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      name: user.name,
      lastname: user.lastname,
      email: user.email,
      cars: render_many(user.cars, CarView, "car.json")
    }
  end

  def render("token.json", %{user: user, token: token}) do
    %{
      email: user.email,
      token: token
    }
  end
end
