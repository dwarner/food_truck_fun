defmodule FoodTruckFun.Utilities.CsvImporter do
  @moduledoc """
  This module takes food truck data from a csv file and inserts it into our db.

  `csv_import` loads and sanitizes the data found by the .csv file set by `@filename`.

  NOTE: It will only import records where the status is "APPROVED" and a LocationDescription is set.

  To import the CSV file set by @filename:
  iex> FoodTruckFun.Utilities.CsvImporter.csv_import()
  """

  require CSV
  require Logger

  alias FoodTruckFun.Businesses
  alias FoodTruckFun.Locations

  @filename "../../data/Mobile_Food_Facility_Permit.csv"

  @doc """
  Imports csv file set by module attribute `@filename`.

  ## Examples

    iex> FoodTruckFun.Utilities.CsvImporter.csv_import()
    :ok

  """
  def csv_import do
    csv_decoder()
    |> sanitize_records()
    |> import_businesses()
    |> import_locations()
  end

  @doc """
  Returns a list of records for the csv file defined in `@filename`

  ## Examples

    iex> FoodTruckFun.Utilities.CsvImporter.csv_decoder()
    [ok: %{}, ...]

  """
  def csv_decoder do
    @filename
    |> Path.expand(__DIR__)
    |> File.stream!
    |> CSV.decode(headers: headers(),
                  field_transform: &String.trim/1)
    |> Enum.to_list()
    |> List.delete_at(0)
  end

  @doc """
  Takes a list of records and returns a list of sanitized records:
    * status => "APPROVED"
    * location_description => !""

  ## Examples

    iex> FoodTruckFun.Utilities.CsvImporter.sanitize_records(records)
    [ok: %{}, ...]

  """
  def sanitize_records(records) do
    records
    |> only_approved()
    |> has_location_description()
  end

  @doc """
  Imports new "Applicants" into the `businesses` table.

  ## Examples

    iex> FoodTruckFun.Utilities.CsvImporter.import_businesses(records)
    [{:ok, 5171, %{}}, ...}]

  """
  def import_businesses(records) do
    for record <- records do
      {:ok, fields} = record
      business_name = fields["business_name"]

      try do
        business = Businesses.get_business_by_name!(business_name)
        {:ok, business.id, fields}
      rescue
        Ecto.NoResultsError ->
          {:ok, business} = Businesses.create_business(%{name: fields["business_name"]})
          {:ok, business.id, fields}
      end
    end
  end

  @doc """
  Imports new locations into the `locations` table.

  ## Examples

    iex> FoodTruckFun.Utilities.CsvImporter.import_locations(records)
    [{:ok, 1293}, ...}]

  """
  def import_locations(records) do
    records
    |> Enum.filter(fn x -> :ok in Tuple.to_list(x) end)
    |> Enum.map(fn {:ok, business_id, fields} = _x ->
      attrs = Map.put(fields, "business_id", business_id)

      date = cast_date(attrs["expiration_date"])
      attrs = Map.put(attrs, "expiration_date", date)

      try do
        location = Locations.get_location_by_external_location_id!(attrs["external_location_id"])
        {:ok, location.id}
      rescue
        Ecto.NoResultsError ->
          {:ok, location} = Locations.create_location(attrs)
          {:ok, location.id}
      end
    end)
  end

  defp only_approved(records) do
    Enum.filter(records, fn {:ok, record} ->
      record["status"] == "APPROVED"
    end)
  end

  defp has_location_description(records) do
    Enum.filter(records, fn {:ok, record} ->
      record["location_description"] != ""
    end)
  end

  defp cast_date(date) do
    [date | _tail] = String.split(date, " ")
    [mm, dd, yyyy] = String.split(date, "/")
    {:ok, date} = Date.from_iso8601("#{yyyy}-#{mm}-#{dd}")
    date
  end

  defp headers() do
    [
      "external_location_id",
      "business_name",
      "facility_type",
      "cnn",
      "location_description",
      "address",
      "blocklot",
      "block",
      "lot",
      "permit",
      "status",
      "food_items",
      "x",
      "y",
      "latitude",
      "longitude",
      "schedule",
      "day_hours",
      "noi_sent",
      "approved_on",
      "received_on",
      "prior_permit",
      "expiration_date",
      "location"
    ]
  end
end
