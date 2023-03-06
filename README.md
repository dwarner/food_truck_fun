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

## Example requests with CURL

**List**
```bash
curl http://localhost:4000/businesses
```

**Create**
```bash
curl -H "Content-Type: application/json" \
     -X POST \
     -d '{"post": {"name":"Tacos El Flaco"} }' \
     http://localhost:4000/businesses
```

**Update**
```bash
curl -H "Content-Type: application/json" \
     -X PUT \
     -d '{"post": {"name":"Brazuca Grill"} }' \
     http://localhost:4000/businesses/1
```

**Delete**
```bash
curl -X DELETE \
     http://localhost:4000/businesses/1
```

## Roadmap Possibilities

* Dockerize
* OpenAPI documentation
* Setup CD/CI
* UUID
* Scope to "v1"
* Authentication
* Implement GraphQL
* Pagination
* Caching