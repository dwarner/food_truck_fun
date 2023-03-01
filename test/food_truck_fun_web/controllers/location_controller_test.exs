defmodule FoodTruckFunWeb.LocationControllerTest do
  use FoodTruckFunWeb.ConnCase

  import FoodTruckFun.LocationsFixtures

  alias FoodTruckFun.Locations.Location

  @create_attrs %{
    expiration_date: ~D[2023-02-28],
    external_location_id: 42,
    facility_type: "some facility_type",
    food_items: "some food_items",
    latitude: "some latitude",
    location_description: "some location_description",
    longitude: "some longitude",
    schedule: "some schedule"
  }
  @update_attrs %{
    expiration_date: ~D[2023-03-01],
    external_location_id: 43,
    facility_type: "some updated facility_type",
    food_items: "some updated food_items",
    latitude: "some updated latitude",
    location_description: "some updated location_description",
    longitude: "some updated longitude",
    schedule: "some updated schedule"
  }
  @invalid_attrs %{expiration_date: nil, external_location_id: nil, facility_type: nil, food_items: nil, latitude: nil, location_description: nil, longitude: nil, schedule: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all locations", %{conn: conn} do
      conn = get(conn, ~p"/api/locations")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create location" do
    test "renders location when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/locations", location: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/locations/#{id}")

      assert %{
               "id" => ^id,
               "expiration_date" => "2023-02-28",
               "external_location_id" => 42,
               "facility_type" => "some facility_type",
               "food_items" => "some food_items",
               "latitude" => "some latitude",
               "location_description" => "some location_description",
               "longitude" => "some longitude",
               "schedule" => "some schedule"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/locations", location: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update location" do
    setup [:create_location]

    test "renders location when data is valid", %{conn: conn, location: %Location{id: id} = location} do
      conn = put(conn, ~p"/api/locations/#{location}", location: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/locations/#{id}")

      assert %{
               "id" => ^id,
               "expiration_date" => "2023-03-01",
               "external_location_id" => 43,
               "facility_type" => "some updated facility_type",
               "food_items" => "some updated food_items",
               "latitude" => "some updated latitude",
               "location_description" => "some updated location_description",
               "longitude" => "some updated longitude",
               "schedule" => "some updated schedule"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, location: location} do
      conn = put(conn, ~p"/api/locations/#{location}", location: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete location" do
    setup [:create_location]

    test "deletes chosen location", %{conn: conn, location: location} do
      conn = delete(conn, ~p"/api/locations/#{location}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/locations/#{location}")
      end
    end
  end

  defp create_location(_) do
    location = location_fixture()
    %{location: location}
  end
end
