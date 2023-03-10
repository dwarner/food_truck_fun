defmodule FoodTruckFun.Locations do
  @moduledoc """
  The Locations context.
  """

  import Ecto.Query, warn: false
  alias FoodTruckFun.Repo

  alias FoodTruckFun.Locations.Location

  @doc """
  Returns the list of locations.

  ## Examples

      iex> list_locations()
      [%Location{}, ...]

  """
  def list_locations do
    Location |> not_expired |> Repo.all()
  end

  @doc """
  Gets a single location.

  Raises `Ecto.NoResultsError` if the Location does not exist.

  ## Examples

      iex> get_location!(123)
      %Location{}

      iex> get_location!(456)
      ** (Ecto.NoResultsError)

  """
  def get_location!(id), do: Repo.get!(Location, id)

  @doc """
  Gets a single location by `external_location_id`.

  Raises `Ecto.NoResultsError` if the Location does not exist.

  ## Examples

      iex> get_location_by_external_location_id!(123)
      %Location{}

      iex> get_location_by_external_location_id!(456)
      ** (Ecto.NoResultsError)

  """
  def get_location_by_external_location_id!(external_location_id) do
    Repo.one!(from l in Location, where: l.external_location_id == ^external_location_id)
  end

  @doc """
  Creates a location.

  ## Examples

      iex> create_location(%{field: value})
      {:ok, %Location{}}

      iex> create_location(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_location(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a location.

  ## Examples

      iex> update_location(location, %{field: new_value})
      {:ok, %Location{}}

      iex> update_location(location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_location(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a location.

  ## Examples

      iex> delete_location(location)
      {:ok, %Location{}}

      iex> delete_location(location)
      {:error, %Ecto.Changeset{}}

  """
  def delete_location(%Location{} = location) do
    Repo.delete(location)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking location changes.

  ## Examples

      iex> change_location(location)
      %Ecto.Changeset{data: %Location{}}

  """
  def change_location(%Location{} = location, attrs \\ %{}) do
    Location.changeset(location, attrs)
  end

  defp not_expired(location) do
    now = NaiveDateTime.local_now()
    where(location, [l], l.expiration_date >= ^now)
  end
end
