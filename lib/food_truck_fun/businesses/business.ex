defmodule FoodTruckFun.Businesses.Business do
  use Ecto.Schema
  import Ecto.Changeset

  schema "businesses" do
    field :name, :string

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
