defmodule ApiLogbook.Accounts.Car do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiLogbook.Accounts.User
  alias ApiLogbook.Trips.Trip

  schema "cars" do
    field :category, :string
    field :manufacturer, :string
    field :model, :string
    field :objectId, :string
    field :year, :integer
    belongs_to :user, User
    has_many :trips, Trip

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, [:objectId, :manufacturer, :model, :category, :year, :user_id])
    |> validate_required([:objectId, :manufacturer, :model, :category, :year, :user_id])
  end
end
