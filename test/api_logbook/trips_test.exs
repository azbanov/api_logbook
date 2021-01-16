defmodule ApiLogbook.TripsTest do
  use ApiLogbook.DataCase

  alias ApiLogbook.Trips

  describe "trips" do
    alias ApiLogbook.Trips.Trip

    @valid_attrs %{addition_expense: 120.5, aim: "some aim", business: 42, consumption: 120.5, date: "2010-04-17T14:00:00Z", notes: "some notes", place: "some place", private: 42}
    @update_attrs %{addition_expense: 456.7, aim: "some updated aim", business: 43, consumption: 456.7, date: "2011-05-18T15:01:01Z", notes: "some updated notes", place: "some updated place", private: 43}
    @invalid_attrs %{addition_expense: nil, aim: nil, business: nil, consumption: nil, date: nil, notes: nil, place: nil, private: nil}

    def trip_fixture(attrs \\ %{}) do
      {:ok, trip} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Trips.create_trip()

      trip
    end

    test "list_trips/0 returns all trips" do
      trip = trip_fixture()
      assert Trips.list_trips() == [trip]
    end

    test "get_trip!/1 returns the trip with given id" do
      trip = trip_fixture()
      assert Trips.get_trip!(trip.id) == trip
    end

    test "create_trip/1 with valid data creates a trip" do
      assert {:ok, %Trip{} = trip} = Trips.create_trip(@valid_attrs)
      assert trip.addition_expense == 120.5
      assert trip.aim == "some aim"
      assert trip.business == 42
      assert trip.consumption == 120.5
      assert trip.date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert trip.notes == "some notes"
      assert trip.place == "some place"
      assert trip.private == 42
    end

    test "create_trip/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trips.create_trip(@invalid_attrs)
    end

    test "update_trip/2 with valid data updates the trip" do
      trip = trip_fixture()
      assert {:ok, %Trip{} = trip} = Trips.update_trip(trip, @update_attrs)
      assert trip.addition_expense == 456.7
      assert trip.aim == "some updated aim"
      assert trip.business == 43
      assert trip.consumption == 456.7
      assert trip.date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert trip.notes == "some updated notes"
      assert trip.place == "some updated place"
      assert trip.private == 43
    end

    test "update_trip/2 with invalid data returns error changeset" do
      trip = trip_fixture()
      assert {:error, %Ecto.Changeset{}} = Trips.update_trip(trip, @invalid_attrs)
      assert trip == Trips.get_trip!(trip.id)
    end

    test "delete_trip/1 deletes the trip" do
      trip = trip_fixture()
      assert {:ok, %Trip{}} = Trips.delete_trip(trip)
      assert_raise Ecto.NoResultsError, fn -> Trips.get_trip!(trip.id) end
    end

    test "change_trip/1 returns a trip changeset" do
      trip = trip_fixture()
      assert %Ecto.Changeset{} = Trips.change_trip(trip)
    end
  end
end
