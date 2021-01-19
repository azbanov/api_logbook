defmodule ApiLogbookWeb.UserView do
  use ApiLogbookWeb, :view

  alias ApiLogbookWeb.{CarView, UserView}

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      lastname: user.lastname,
      email: user.email,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end

  def render("user_and_cars.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      lastname: user.lastname,
      email: user.email,
      cars: render_many(user.cars, CarView, "car.json")
    }
  end

  def render("token.json", %{user: user, token: token}) do
    %{
      id: user.id,
      token: token
    }
  end
end
