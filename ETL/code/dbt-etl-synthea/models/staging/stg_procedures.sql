{{ config(materialized='table', alias='procedures') }}

with source as (
    select
        "START",
        "STOP",
        "PATIENT",
        "ENCOUNTER",
        "SYSTEM",
        "CODE",
        "DESCRIPTION"
    from {{ ref('procedures') }}
)
select
    "PATIENT" as patient_id,
    "ENCOUNTER" as encounter_id,
    cast("START" as date) as procedure_date,
    cast("START" as timestamp) as procedure_datetime,
    cast("STOP" as date) as procedure_end_date,
    cast("STOP" as timestamp) as procedure_end_datetime,
    "CODE" as source_code,
    "CODE" as procedure_code,
    "DESCRIPTION" as source_description,
    "DESCRIPTION" as procedure_description,
    'SNOMED' as source_vocabulary_id
from source
