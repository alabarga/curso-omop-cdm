{{ config(materialized='table', alias='patients') }}

select
    Id as patient_id,
    date(BIRTHDATE) as birth_date,
    date(DEATHDATE) as death_date,
    upper(trim(GENDER)) as gender,
    upper(trim(GENDER)) as gender_source_value,
    upper(trim(RACE)) as race,
    upper(trim(RACE)) as race_source_value,
    upper(trim(ETHNICITY)) as ethnicity,
    upper(trim(ETHNICITY)) as ethnicity_source_value,
    trim(CITY) as city,
    upper(trim(STATE)) as state_name,
    trim(cast(ZIP as varchar)) as zip,
    trim(ADDRESS) as street_address,
    trim(COUNTY) as county,
    cast(LAT as double) as latitude,
    cast(LON as double) as longitude,
    Id as patient_source_value,
    cast(HEALTHCARE_EXPENSES as double) as healthcare_expenses,
    cast(HEALTHCARE_COVERAGE as double) as healthcare_coverage,
    cast(INCOME as double) as income
from {{ ref('patients') }}
