{{ config(materialized='table', alias='patients') }}

select
    "Id" as patient_id,
    cast("BIRTHDATE" as date) as birth_date,
    cast("DEATHDATE" as date) as death_date,
    upper(trim("GENDER")) as gender,
    upper(trim("GENDER")) as gender_source_value,
    upper(trim("RACE")) as race,
    upper(trim("RACE")) as race_source_value,
    upper(trim("ETHNICITY")) as ethnicity,
    upper(trim("ETHNICITY")) as ethnicity_source_value,
    trim("CITY") as city,
    upper(trim("STATE")) as state_name,
    trim(cast("ZIP" as varchar)) as zip,
    trim("ADDRESS") as street_address,
    trim("COUNTY") as county,
    cast("LAT" as float) as latitude,
    cast("LON" as float) as longitude,
    "Id" as patient_source_value,
    cast("HEALTHCARE_EXPENSES" as float) as healthcare_expenses,
    cast("HEALTHCARE_COVERAGE" as float) as healthcare_coverage,
    cast("INCOME" as float) as income
from {{ ref('patients') }}
