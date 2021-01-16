defmodule ApiLogbookWeb.UserController do
  use ApiLogbookWeb, :controller

  alias ApiLogbook.Accounts
  alias ApiLogbook.Accounts.User
  alias ApiLogbookWeb.Auth.Guardian

  action_fallback ApiLogbookWeb.FallbackController

  def index(conn, _params) do
    render conn, "index.json", %{users: Accounts.list_users}
  end

  def show(conn, %{"id" => id}) do
    render conn, "show.json", %{user: Accounts.get_user!(id)}
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
    {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("token.json", %{user: user, token: token})
    end
  end

  def signin(conn, %{"email" => email, "password" => password}) do
    with {:ok, user, token} <- Guardian.authenticate(email, password) do
      conn
      |> put_status(:created)
      |> render("token.json", %{user: user, token: token})
    end
  end
end
