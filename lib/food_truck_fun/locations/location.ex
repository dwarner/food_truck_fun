defmodule FoodTruckFun.Locations.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :external_location_id, :integer
    field :expiration_date, :date
    field :facility_type, :string
    field :food_items, :string
    field :location_description, :string
    field :latitude, :string
    field :longitude, :string
    field :schedule, :string
    field :business_id, :id

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:external_location_id, :expiration_date, :facility_type, :food_items, :latitude, :longitude, :location_description, :schedule])
    |> validate_required([:external_location_id, :expiration_date, :facility_type, :food_items, :latitude, :longitude, :location_description, :schedule])
    |> unique_constraint(:unique_location_external_location_id, name: :external_location_id_index)
  end
end
