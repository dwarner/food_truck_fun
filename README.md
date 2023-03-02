# FoodTruckFun

FoodTruckFun is an API to return some basic but useful information for Food Tucks (and carts!)
in the San Fansico area.

Public data is accessible here:
[Data SF Mobile Food Facility Permit Data](https://data.sfgov.org/Economy-and-Community/Mobile-Food-Facility-Permit/rqzj-sfat/data)

A downloaded CSV file named `Mobile_Food_Facility_Permit.csv` is included in the `data` directory.

You can run 
```
iex> FoodTruckFun.Utilities.CsvImporter.csv_import() 
```

## Roadmap Possibilities

* OpenAPI
* Code coverage hex package
* Setup CD/CI
* UUID
* Scope to "v1"
* Implement GraphQL