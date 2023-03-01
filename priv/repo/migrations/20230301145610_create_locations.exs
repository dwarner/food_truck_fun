defmodule FoodTruckFun.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :external_location_id, :integer, null: false
      add :expiration_date, :date, null: false
      add :facility_type, :string, null: false
      add :food_items, :string, null: false
      add :latitude, :string, null: false
      add :longitude, :string, null: false
      add :location_description, :string, null: false
      add :schedule, :string
      add :business_id, references(:businesses, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:locations, [:business_id])
    create unique_index(:locations, [:external_location_id])
  end
end
