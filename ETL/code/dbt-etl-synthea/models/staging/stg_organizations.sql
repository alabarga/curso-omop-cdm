{{ config(materialized='table', alias='organizations') }}

select
    "Id" as organization_id,
    "NAME" as name,
    trim("CITY") as city,
    upper(trim("STATE")) as state_name,
    "ZIP" as zip,
    "ADDRESS" as address,
    cast("LAT" as float) as latitude,
    cast("LON" as float) as longitude,
    "PHONE" as phone,
    cast("REVENUE" as float) as revenue,
    cast("UTILIZATION" as float) as utilization
from {{ ref('organizations') }}
