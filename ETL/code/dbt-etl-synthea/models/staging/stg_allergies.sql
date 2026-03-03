{{ config(materialized='table', alias='allergies') }}

with source as (
    select *
    from {{ ref('allergies') }}
)
select
    "PATIENT" as patient_id,
    "ENCOUNTER" as encounter_id,
    cast("START" as date) as allergy_start_date,
    cast("START" as timestamp) as allergy_start_datetime,
    cast("STOP" as date) as allergy_end_date,
    cast("STOP" as timestamp) as allergy_end_datetime,
    "CODE" as allergy_code,
    "DESCRIPTION" as allergy_description,
    upper(trim("SYSTEM")) as source_system,
    case upper(trim("SYSTEM"))
        when 'SNOMED-CT' then 'SNOMED'
        else upper(trim("SYSTEM"))
    end as coding_system
from source
