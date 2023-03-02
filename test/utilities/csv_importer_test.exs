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
        "address" => "5 THE EMBARCADERO",
        "business_name" => "Ziaurehman Amini",
        "expiration_date" => "03/15/2016 12:00:00 AM",
        "external_location_id" => "735318",
        "facility_type" => "Push Cart",
        "food_items" => "Pizza by the slice!",
        "latitude" => "37.794331003246846",
        "location_description" => "MARKET ST: DRUMM ST intersection",
        "longitude" => "-122.39581105302317",
        "schedule" => "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=15MFF-0159&ExportPDF=1&Filename=15MFF-0159_schedule.pdf",
        "status" => "EXPIRED"
      },
      ok: %{
        "address" => "2155 37TH AVE",
        "business_name" => "Sunset Mercantile/Outer Sunset Farmers Market & Mercantile",
        "expiration_date" => "11/15/2022 12:00:00 AM",
        "external_location_id" => "1612654",
        "facility_type" => "Truck",
        "food_items" => "Multiple Food Trucks & Food Types",
        "latitude" => "37.74732654654123",
        "location_description" => "37TH AVE: QUINTARA ST to RIVERA ST (2100 - 2199)",
        "longitude" => "-122.49628067270531",
        "schedule" => "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=22MFF-00031&ExportPDF=1&Filename=22MFF-00031_schedule.pdf",
        "status" => "REQUESTED"
      },
      ok: %{
        "address" => "185 BERRY ST",
        "business_name" => "Off the Grid Services, LLC",
        "expiration_date" => "11/15/2023 12:00:00 AM",
        "external_location_id" => "1652610",
        "facility_type" => "Truck",
        "food_items" => "everything except for hot dogs",
        "latitude" => "37.77632714778992",
        "location_description" => "BERRY ST: 03RD ST to 04TH ST (100 - 199)",
        "longitude" => "-122.39179682107691",
        "schedule" => "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=22MFF-00035&ExportPDF=1&Filename=22MFF-00035_schedule.pdf",
        "status" => "SUSPEND"
      },
      ok: %{
        "address" => "430 CALIFORNIA ST",
        "business_name" => "Bonito Poke",
        "expiration_date" => "11/15/2023 12:00:00 AM",
        "external_location_id" => "1658690",
        "facility_type" => "Truck",
        "food_items" => "Bonito Poke Bowls & Various Drinks",
        "latitude" => "37.793262206923096",
        "location_description" => "CALIFORNIA ST: SANSOME ST to LEIDESDORFF ST (400 - 448)",
        "longitude" => "-122.4017890913628",
        "schedule" => "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=22MFF-00070&ExportPDF=1&Filename=22MFF-00070_schedule.pdf",
        "status" => "APPROVED"
      },
      ok: %{
        "address" => "185 BERRY ST",
        "business_name" => "Off the Grid Services, LLC",
        "expiration_date" => "11/15/2023 12:00:00 AM",
        "external_location_id" => "1652620",
        "facility_type" => "Truck",
        "food_items" => "everything except for hot dogs",
        "latitude" => "37.77632714778992",
        "location_description" => "",
        "longitude" => "-122.39179682107691",
        "schedule" => "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=22MFF-00036&ExportPDF=1&Filename=22MFF-00036_schedule.pdf",
        "status" => "APPROVED"
      }
    ]

    test "sanitize_records/1 returns only 'APPROVED' permits" do
      assert CsvImporter.sanitize_records(@records) |> length == 1
    end

    test "import_businesses/1 imports businsesses into the db" do
      assert CsvImporter.import_businesses(@records) |> length == 5
    end

    test "import_locations/1 imports locations into the db" do
      locations = @records
                  |> CsvImporter.sanitize_records()
                  |> CsvImporter.import_businesses()
                  |> CsvImporter.import_locations()
                  |> length

      assert locations == 1
    end
  end
end
