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

    timestamps()
  end

  @doc false
  def changeset(trip, attrs) do

    rest = trip
    |> change(%{date: to_naive_time!(attrs["date"])})
    |> cast(attrs, [:date, :place, :aim, :business, :private, :consumption, :addition_expense, :notes, :car_id])
    # |> validate_required([:date, :place, :aim, :business, :private, :consumption, :addition_expense, :notes, :car_id])

    IO.inspect rest
  end

  defp to_naive_time!(timestamp) do
    res = timestamp
    |> DateTime.from_unix!()
    
    res

  end
end
