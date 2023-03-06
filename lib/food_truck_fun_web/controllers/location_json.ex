defmodule FoodTruckFunWeb.LocationJSON do
  @moduledoc """
  JSON structure for locations.
  """
  alias FoodTruckFun.Locations.Location

  @doc """
  Renders a list of locations.
  """
  def index(%{locations: locations}) do
    %{data: for(location <- locations, do: data(location))}
  end

  @doc """
  Renders a single location.
  """
  def show(%{location: location}) do
    %{data: data(location)}
  end

  defp data(%Location{} = location) do
    %{
      id: location.id,
      external_location_id: location.external_location_id,
      expiration_date: location.expiration_date,
      facility_type: location.facility_type,
      food_items: location.food_items,
      latitude: location.latitude,
      longitude: location.longitude,
      location_description: location.location_description,
      schedule: location.schedule
    }
  end
end
