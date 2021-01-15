defmodule ApiLogbook.AccountsTest do
  use ApiLogbook.DataCase

  alias ApiLogbook.Accounts

  describe "users" do
    alias ApiLogbook.Accounts.User

    @valid_attrs %{email: "some email", lastname: "some lastname", name: "some name", password: "some password"}
    @update_attrs %{email: "some updated email", lastname: "some updated lastname", name: "some updated name", password: "some updated password"}
    @invalid_attrs %{email: nil, lastname: nil, name: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.lastname == "some lastname"
      assert user.name == "some name"
      assert user.password == "some password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.lastname == "some updated lastname"
      assert user.name == "some updated name"
      assert user.password == "some updated password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "cars" do
    alias ApiLogbook.Accounts.Car

    @valid_attrs %{category: "some category", manufacturer: "some manufacturer", model: "some model", objectId: "some objectId", year: 42}
    @update_attrs %{category: "some updated category", manufacturer: "some updated manufacturer", model: "some updated model", objectId: "some updated objectId", year: 43}
    @invalid_attrs %{category: nil, manufacturer: nil, model: nil, objectId: nil, year: nil}

    def car_fixture(attrs \\ %{}) do
      {:ok, car} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_car()

      car
    end

    test "list_cars/0 returns all cars" do
      car = car_fixture()
      assert Accounts.list_cars() == [car]
    end

    test "get_car!/1 returns the car with given id" do
      car = car_fixture()
      assert Accounts.get_car!(car.id) == car
    end

    test "create_car/1 with valid data creates a car" do
      assert {:ok, %Car{} = car} = Accounts.create_car(@valid_attrs)
      assert car.category == "some category"
      assert car.manufacturer == "some manufacturer"
      assert car.model == "some model"
      assert car.objectId == "some objectId"
      assert car.year == 42
    end

    test "create_car/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_car(@invalid_attrs)
    end

    test "update_car/2 with valid data updates the car" do
      car = car_fixture()
      assert {:ok, %Car{} = car} = Accounts.update_car(car, @update_attrs)
      assert car.category == "some updated category"
      assert car.manufacturer == "some updated manufacturer"
      assert car.model == "some updated model"
      assert car.objectId == "some updated objectId"
      assert car.year == 43
    end

    test "update_car/2 with invalid data returns error changeset" do
      car = car_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_car(car, @invalid_attrs)
      assert car == Accounts.get_car!(car.id)
    end

    test "delete_car/1 deletes the car" do
      car = car_fixture()
      assert {:ok, %Car{}} = Accounts.delete_car(car)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_car!(car.id) end
    end

    test "change_car/1 returns a car changeset" do
      car = car_fixture()
      assert %Ecto.Changeset{} = Accounts.change_car(car)
    end
  end
end
