defmodule ApiLogbook.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiLogbook.Accounts.Car

  schema "users" do
    field :email, :string
    field :lastname, :string
    field :name, :string
    field :password, :string
    field :virtual_password, :string, virtual: true
    has_many :car, Car

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :lastname, :email, :password])
    |> validate_required([:name, :lastname, :email, :password])
    |> validate_format(:email, ~r/^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
    |> put_hashed_password()
  end

  defp put_hashed_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hash_pwd_salt(password))
  end

  defp put_hashed_password(changeset), do: changeset
end
