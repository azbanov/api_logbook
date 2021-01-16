defmodule ApiLogbookWeb.TripControllerTest do
  use ApiLogbookWeb.ConnCase

  alias ApiLogbook.Trips
  alias ApiLogbook.Trips.Trip

  @create_attrs %{
    addition_expense: 120.5,
    aim: "some aim",
    business: 42,
    consumption: 120.5,
    date: "2010-04-17T14:00:00Z",
    notes: "some notes",
    place: "some place",
    private: 42
  }
  @update_attrs %{
    addition_expense: 456.7,
    aim: "some updated aim",
    business: 43,
    consumption: 456.7,
    date: "2011-05-18T15:01:01Z",
    notes: "some updated notes",
    place: "some updated place",
    private: 43
  }
  @invalid_attrs %{addition_expense: nil, aim: nil, business: nil, consumption: nil, date: nil, notes: nil, place: nil, private: nil}

  def fixture(:trip) do
    {:ok, trip} = Trips.create_trip(@create_attrs)
    trip
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all trips", %{conn: conn} do
      conn = get(conn, Routes.trip_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create trip" do
    test "renders trip when data is valid", %{conn: conn} do
      conn = post(conn, Routes.trip_path(conn, :create), trip: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.trip_path(conn, :show, id))

      assert %{
               "id" => id,
               "addition_expense" => 120.5,
               "aim" => "some aim",
               "business" => 42,
               "consumption" => 120.5,
               "date" => "2010-04-17T14:00:00Z",
               "notes" => "some notes",
               "place" => "some place",
               "private" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.trip_path(conn, :create), trip: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update trip" do
    setup [:create_trip]

    test "renders trip when data is valid", %{conn: conn, trip: %Trip{id: id} = trip} do
      conn = put(conn, Routes.trip_path(conn, :update, trip), trip: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.trip_path(conn, :show, id))

      assert %{
               "id" => id,
               "addition_expense" => 456.7,
               "aim" => "some updated aim",
               "business" => 43,
               "consumption" => 456.7,
               "date" => "2011-05-18T15:01:01Z",
               "notes" => "some updated notes",
               "place" => "some updated place",
               "private" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, trip: trip} do
      conn = put(conn, Routes.trip_path(conn, :update, trip), trip: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete trip" do
    setup [:create_trip]

    test "deletes chosen trip", %{conn: conn, trip: trip} do
      conn = delete(conn, Routes.trip_path(conn, :delete, trip))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.trip_path(conn, :show, trip))
      end
    end
  end

  defp create_trip(_) do
    trip = fixture(:trip)
    %{trip: trip}
  end
end
