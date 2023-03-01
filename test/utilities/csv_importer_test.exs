defmodule Utilities.CsvImporterTest do
  use ExUnit.Case

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(FoodTruckFun.Repo)
  end

  alias FoodTruckFun.Utilities.CsvImporter

  describe "csv_importer" do
    @records [
      ok: %{
        "Address" => "2535 TAYLOR ST",
        "Applicant" => "Datam SF LLC dba Anzu To You",
        "Approved" => "11/05/2021 12:00:00 AM",
        "ExpirationDate" => "11/15/2022 12:00:00 AM",
        "FacilityType" => "Truck",
        "FoodItems" => "Asian Fusion - Japanese Sandwiches/Sliders/Misubi",
        "Latitude" => "37.805885350100986",
        "Location" => "(37.805885350100986, -122.41594524663745)",
        "LocationDescription" => "TAYLOR ST: BAY ST to NORTH POINT ST (2500 - 2599)",
        "Longitude" => "-122.41594524663745",
        "Schedule" => "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=21MFF-00106&ExportPDF=1&Filename=21MFF-00106_schedule.pdf",
        "Status" => "APPROVED"
      },
      ok: %{
        "Address" => "Assessors Block 7283/Lot004",
        "Applicant" => "Casita Vegana",
        "Approved" => "11/05/2021 12:00:00 AM",
        "ExpirationDate" => "11/15/2022 12:00:00 AM",
        "FacilityType" => "Truck",
        "FoodItems" => "Coffee: Vegan Pastries: Vegan Hot Dogs: Vegan Tamales: Te: Vegan Shakes",
        "Latitude" => "37.72188970870838",
        "Location" => "(37.72188970870838, -122.4925212449949)",
        "LocationDescription" => "JOHN MUIR DR: LAKE MERCED BLVD to SKYLINE BLVD (200 - 699)",
        "Longitude" => "-122.4925212449949",
        "Schedule" => "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=21MFF-00105&ExportPDF=1&Filename=21MFF-00105_schedule.pdf",
        "Status" => "EXPIRED"
      },
      ok: %{
        "Address" => "351 CALIFORNIA ST",
        "Applicant" => "MOMO INNOVATION LLC",
        "Approved" => "10/22/2021 12:00:00 AM",
        "ExpirationDate" => "11/15/2022 12:00:00 AM",
        "FacilityType" => "Truck",
        "FoodItems" => "Noodles: Meat & Drinks",
        "Latitude" => "37.792870749741496",
        "Location" => "(37.792870749741496, -122.4007474940767)",
        "LocationDescription" => "CALIFORNIA ST: BATTERY ST to SANSOME ST (300 - 399)",
        "Longitude" => "-122.4007474940767",
        "Schedule" => "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=21MFF-00090&ExportPDF=1&Filename=21MFF-00090_schedule.pdf",
        "Status" => "REQUESTED"
      },
      ok: %{
        "Address" => "667 MISSION ST",
        "Applicant" => "MOMO INNOVATION LLC",
        "Approved" => "10/22/2021 12:00:00 AM",
        "ExpirationDate" => "11/15/2022 12:00:00 AM",
        "FacilityType" => "Truck",
        "FoodItems" => "Noodles: Meat & Drinks",
        "Latitude" => "37.7865580501799",
        "Location" => "(37.7865580501799, -122.40103337534973)",
        "LocationDescription" => "MISSION ST: ANNIE ST to 03RD ST (663 - 699)",
        "Longitude" => "-122.40103337534973",
        "Schedule" => "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=21MFF-00090&ExportPDF=1&Filename=21MFF-00090_schedule.pdf",
        "Status" => "SUSPEND"
      }
    ]

    test "sanitize_records/1 returns only 'APPROVED' permits" do
      assert CsvImporter.sanitize_records(@records) |> length == 1
    end

    test "import_into_db/1 only imports businsesses not already in the db" do
     assert :ok == CsvImporter.import_into_db(@records)
    end
  end
end
