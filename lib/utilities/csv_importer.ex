defmodule FoodTruckFun.Utilities.CsvImporter do
  @moduledoc """
  This module takes food truck data from a csv file and inserts it into our db.

  `csv_import` loads and sanitizes the data found by the .csv file set by `@filename`.

  To import the CSV file set by @filename:
  iex> FoodTruckFun.Utilities.CsvImporter.csv_import()
  """

  require CSV
  require Logger

  alias FoodTruckFun.Businesses

  @filename "../../data/Mobile_Food_Facility_Permit.csv"

  @doc """
  Imports csv file set by module attribute `@filename`.

  ## Examples

    iex> FoodTruckFun.Utilities.CsvImporter.csv_import()
    [ok: %{}, ...]

  """
  def csv_import do
    csv_decoder()
    |> sanitize_records()
    |> import_into_db()
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
    |> CSV.decode(headers: true, field_transform: &String.trim/1)
    |> Enum.to_list()
  end

  @doc """
  Takes a list of records and returns a list of sanitized records:
    * Status => "APPROVED"

  ## Examples

    iex> FoodTruckFun.Utilities.CsvImporter.sanitize_records(records)
    [ok: %{}, ...]

  """
  def sanitize_records(records) do
    records
    |> only_approved()
  end

  @doc """
  Imports a list of records into the dabase.
  New "Applicants" are added to the `businesses` table.

  ## Examples

    iex> FoodTruckFun.Utilities.CsvImporter.import_into_db(records)
    Imported 0 businesses from csv.
    There were 148 errors (see logs).
    :ok
  """
  def import_into_db(records) do
    import_results =
      for record <- records do
        {:ok, %{"Applicant" => name}} = record

        case Businesses.create_business(%{name: name}) do
          {:ok, business} ->
            Logger.info("Business \"#{business.name}\" has been added.")
            :ok
          {:error, changeset} ->
            Logger.error("Error inserting business: #{inspect(changeset)}")
            :error
        end
      end |> Enum.frequencies()

    Logger.info("Imported #{import_results[:ok] || 0} businesses from csv.\nThere were #{import_results[:error] || 0} errors (see logs).")
  end

  defp only_approved(records) do
    Enum.filter(records, fn {:ok, record} ->
      record["Status"] == "APPROVED"
    end)
  end
end
