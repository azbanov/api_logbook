defmodule ApiLogbook.Accounts.Car do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiLogbook.Accounts.User

  schema "cars" do
    field :category, :string
    field :manufacturer, :string
    field :model, :string
    field :objectId, :string
    field :year, :integer
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, [:objectId, :manufacturer, :model, :category, :year])
    |> validate_required([:objectId, :manufacturer, :model, :category, :year])
  end
end
