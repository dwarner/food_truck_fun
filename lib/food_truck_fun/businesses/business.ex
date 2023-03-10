defmodule FoodTruckFun.Businesses.Business do
  @moduledoc """
  Schema for businesses.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "businesses" do
    field :name, :string
    has_many :locations, FoodTruckFun.Locations.Location

    timestamps()
  end

  @doc false
  def changeset(business, attrs) do
    business
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:unique_business_name, name: :businesses_name_index)
  end
end
