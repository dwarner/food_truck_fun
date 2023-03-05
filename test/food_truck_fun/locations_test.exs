defmodule FoodTruckFun.LocationsTest do
  use FoodTruckFun.DataCase

  alias FoodTruckFun.Locations

  describe "locations" do
    alias FoodTruckFun.Locations.Location

    import FoodTruckFun.LocationsFixtures

    @invalid_attrs %{expiration_date: nil, external_location_id: nil, facility_type: nil, food_items: nil, latitude: nil, location_description: nil, longitude: nil, schedule: nil}

    test "list_locations/0 returns all locations with permits not expired" do
      location = location_fixture()
      _location_expired = location_fixture_expired()

      assert Locations.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Locations.get_location!(location.id) == location
    end

    test "get_location_by_external_location_id!!/1 returns the location with given external_location_id" do
      location = location_fixture(%{:external_location_id => 123})
      assert Locations.get_location_by_external_location_id!(123) == location
    end

    test "create_location/1 with valid data creates a location" do
      valid_attrs = %{expiration_date: ~D[2023-02-28], external_location_id: 42, facility_type: "some facility_type", food_items: "some food_items", latitude: "some latitude", location_description: "some location_description", longitude: "some longitude", schedule: "some schedule"}

      assert {:ok, %Location{} = location} = Locations.create_location(valid_attrs)
      assert location.expiration_date == ~D[2023-02-28]
      assert location.external_location_id == 42
      assert location.facility_type == "some facility_type"
      assert location.food_items == "some food_items"
      assert location.latitude == "some latitude"
      assert location.location_description == "some location_description"
      assert location.longitude == "some longitude"
      assert location.schedule == "some schedule"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      update_attrs = %{expiration_date: ~D[2023-03-01], external_location_id: 43, facility_type: "some updated facility_type", food_items: "some updated food_items", latitude: "some updated latitude", location_description: "some updated location_description", longitude: "some updated longitude", schedule: "some updated schedule"}

      assert {:ok, %Location{} = location} = Locations.update_location(location, update_attrs)
      assert location.expiration_date == ~D[2023-03-01]
      assert location.external_location_id == 43
      assert location.facility_type == "some updated facility_type"
      assert location.food_items == "some updated food_items"
      assert location.latitude == "some updated latitude"
      assert location.location_description == "some updated location_description"
      assert location.longitude == "some updated longitude"
      assert location.schedule == "some updated schedule"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_location(location, @invalid_attrs)
      assert location == Locations.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Locations.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Locations.change_location(location)
    end
  end
end
