{{ config(materialized='table', alias='conditions') }}

with source as (
    select
        "PATIENT",
        "ENCOUNTER",
        "START",
        "STOP",
        "SYSTEM",
        "CODE",
        "DESCRIPTION"
    from {{ ref('conditions') }}
)
select
    "PATIENT" as patient_id,
    "ENCOUNTER" as encounter_id,
    cast("START" as date) as condition_start_date,
    cast("START" as timestamp) as condition_start_datetime,
    cast("START" as timestamp) as condition_start_ts,
    cast("STOP" as date) as condition_end_date,
    cast("STOP" as timestamp) as condition_end_datetime,
    cast("STOP" as timestamp) as condition_end_ts,
    upper(trim("SYSTEM")) as source_system,
    "CODE" as source_code,
    "CODE" as condition_code,
    "DESCRIPTION" as source_description,
    "DESCRIPTION" as condition_description,
    case upper(trim("SYSTEM"))
        when 'SNOMED-CT' then 'SNOMED'
        when 'ICD-10-CM' then 'ICD10CM'
        when 'ICD10CM' then 'ICD10CM'
        else upper(trim("SYSTEM"))
    end as coding_system
from source
