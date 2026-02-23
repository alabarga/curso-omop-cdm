{{ config(materialized='table', alias='organizations') }}

select
    Id as organization_id,
    NAME as name,
    trim(CITY) as city,
    upper(trim(STATE)) as state_name,
    ZIP as zip,
    ADDRESS as address,
    cast(LAT as double) as latitude,
    cast(LON as double) as longitude,
    PHONE as phone,
    cast(REVENUE as double) as revenue,
    cast(UTILIZATION as double) as utilization
from {{ ref('organizations') }}
