defmodule FoodTruckFun.Utilities.CsvImporter do
  @moduledoc """
  This module takes food truck data from a csv file and inserts it into our db.

  `csv_import` loads and sanitizes the data found by the .csv file set by `@filename`.

  To import the CSV file set by @filename:
  iex> FoodTruckFun.Utilities.CsvImporter.csv_import()
  """

  require CSV
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
  Returns a list of sanitized records:
    * Status => "APPROVED"

  ## Examples

    iex> FoodTruckFun.Utilities.CsvImporter.sanitize_records(records)
    [ok: %{}, ...]

  """
  def sanitize_records(records) do
    records
    |> only_approved()
  end

  defp only_approved(records) do
    Enum.filter(records, fn {:ok, record} ->
      record["Status"] == "APPROVED"
    end)
  end
end
