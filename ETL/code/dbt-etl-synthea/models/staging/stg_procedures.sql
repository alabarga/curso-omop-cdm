{{ config(materialized='table', alias='procedures') }}

with source as (
    select
        START,
        STOP,
        PATIENT,
        ENCOUNTER,
        SYSTEM,
        CODE,
        DESCRIPTION
    from {{ ref('procedures') }}
)
select
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    date(START) as procedure_date,
    datetime(START) as procedure_datetime,
    date(STOP) as procedure_end_date,
    datetime(STOP) as procedure_end_datetime,
    CODE as source_code,
    CODE as procedure_code,
    DESCRIPTION as source_description,
    DESCRIPTION as procedure_description,
    'SNOMED' as source_vocabulary_id
from source
