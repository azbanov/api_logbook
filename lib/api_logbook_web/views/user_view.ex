defmodule ApiLogbookWeb.UserView do
  use ApiLogbookWeb, :view
  
  def render("user.json", %{user: user, token: token}) do
    %{
      email: user.email,
      token: token
    }
  end
end
