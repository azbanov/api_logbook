defmodule ApiLogbook.Trips.Trip do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiLogbook.Accounts.Car

  schema "trips" do
    field :addition_expense, :float
    field :aim, :string
    field :business, :integer
    field :consumption, :float
    field :date, :utc_datetime
    field :notes, :string
    field :place, :string
    field :private, :integer
    belongs_to :car, Car

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(trip, attrs) do
    trip
    |> change(%{date: Timex.parse!(attrs["date"], "{ISO:Extended:Z}")})
    |> cast(attrs, [:date, :place, :aim, :business, :private, :consumption, :addition_expense, :notes, :car_id])
    |> validate_required([:date, :place, :aim, :business, :private, :consumption, :car_id])
  end
end
