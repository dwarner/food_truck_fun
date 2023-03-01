defmodule FoodTruckFunWeb.BusinessController do
  use FoodTruckFunWeb, :controller

  alias FoodTruckFun.Businesses
  alias FoodTruckFun.Businesses.Business

  action_fallback FoodTruckFunWeb.FallbackController

  def index(conn, _params) do
    businesses = Businesses.list_businesses()
    render(conn, :index, businesses: businesses)
  end

  def create(conn, %{"business" => business_params}) do
    with {:ok, %Business{} = business} <- Businesses.create_business(business_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/businesses/#{business}")
      |> render(:show, business: business)
    end
  end

  def show(conn, %{"id" => id}) do
    business = Businesses.get_business!(id)
    render(conn, :show, business: business)
  end

  def update(conn, %{"id" => id, "business" => business_params}) do
    business = Businesses.get_business!(id)

    with {:ok, %Business{} = business} <- Businesses.update_business(business, business_params) do
      render(conn, :show, business: business)
    end
  end

  def delete(conn, %{"id" => id}) do
    business = Businesses.get_business!(id)

    with {:ok, %Business{}} <- Businesses.delete_business(business) do
      send_resp(conn, :no_content, "")
    end
  end
end
