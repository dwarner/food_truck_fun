defmodule FoodTruckFunWeb.BusinessJSON do
  @moduledoc """
  JSON structure for businesses.
  """
  alias FoodTruckFun.Businesses.Business

  @doc """
  Renders a list of businesses.
  """
  def index(%{businesses: businesses}) do
    %{data: for(business <- businesses, do: data(business))}
  end

  @doc """
  Renders a single business.
  """
  def show(%{business: business}) do
    %{data: data(business)}
  end

  defp data(%Business{} = business) do
    %{
      id: business.id,
      name: business.name
    }
  end
end
