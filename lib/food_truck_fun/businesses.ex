defmodule FoodTruckFun.Businesses do
  @moduledoc """
  The Businesses context.
  """

  import Ecto.Query, warn: false
  alias FoodTruckFun.Repo

  alias FoodTruckFun.Businesses.Business

  @doc """
  Returns the list of businesses.

  ## Examples

      iex> list_businesses()
      [%Business{}, ...]

  """
  def list_businesses do
    Repo.all(Business)
  end

  @doc """
  Takes a business name and returns a list of matching businesses.

  ## Examples

    iex> list_businesses_by_name(name)
    [%Business{}, ...]

  """
  def list_businesses_by_name(name) do
    like = "%#{name}%"
    Repo.all(from b in Business, where: ilike(b.name, ^like))
  end

  @doc """
  Gets a single business.

  Raises `Ecto.NoResultsError` if the Business does not exist.

  ## Examples

      iex> get_business!(123)
      %Business{}

      iex> get_business!(456)
      ** (Ecto.NoResultsError)

  """
  def get_business!(id), do: Repo.get!(Business, id)

  @doc """
  Gets a single business by business name.

  Raises `Ecto.NoResultsError` if the Business does not exist.

  ## Examples

      iex> get_business!("La Jefa")
      %Business{}

      iex> get_business!("Invisible Food Truck")
      ** (Ecto.NoResultsError)
  """

  def get_business_by_name!(name) do
    like = "%#{name}%"
    Repo.one!(from b in Business, where: ilike(b.name, ^like))
  end

  @doc """
  Creates a business.

  ## Examples

      iex> create_business(%{field: value})
      {:ok, %Business{}}

      iex> create_business(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_business(attrs \\ %{}) do
    %Business{}
    |> Business.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a business.

  ## Examples

      iex> update_business(business, %{field: new_value})
      {:ok, %Business{}}

      iex> update_business(business, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_business(%Business{} = business, attrs) do
    business
    |> Business.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a business.

  ## Examples

      iex> delete_business(business)
      {:ok, %Business{}}

      iex> delete_business(business)
      {:error, %Ecto.Changeset{}}

  """
  def delete_business(%Business{} = business) do
    Repo.delete(business)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking business changes.

  ## Examples

      iex> change_business(business)
      %Ecto.Changeset{data: %Business{}}

  """
  def change_business(%Business{} = business, attrs \\ %{}) do
    Business.changeset(business, attrs)
  end
end
