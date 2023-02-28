defmodule FoodTruckFun.Repo do
  use Ecto.Repo,
    otp_app: :food_truck_fun,
    adapter: Ecto.Adapters.Postgres
end
