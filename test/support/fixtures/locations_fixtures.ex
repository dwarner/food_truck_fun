defmodule FoodTruckFun.LocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodTruckFun.Locations` context.
  """

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    {:ok, location} =
      attrs
      |> Enum.into(%{
        expiration_date: ~D[2023-02-28],
        external_location_id: 42,
        facility_type: "some facility_type",
        food_items: "some food_items",
        latitude: "some latitude",
        location_description: "some location_description",
        longitude: "some longitude",
        schedule: "some schedule"
      })
      |> FoodTruckFun.Locations.create_location()

    location
  end
end
