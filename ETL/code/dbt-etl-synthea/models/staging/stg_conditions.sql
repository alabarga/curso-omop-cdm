{{ config(materialized='table', alias='conditions') }}

with source as (
    select
        PATIENT,
        ENCOUNTER,
        START,
        STOP,
        SYSTEM,
        CODE,
        DESCRIPTION
    from {{ ref('conditions') }}
)
select
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    date(START) as condition_start_date,
    datetime(START) as condition_start_datetime,
    datetime(START) as condition_start_ts,
    date(STOP) as condition_end_date,
    datetime(STOP) as condition_end_datetime,
    datetime(STOP) as condition_end_ts,
    upper(trim(SYSTEM)) as source_system,
    CODE as source_code,
    CODE as condition_code,
    DESCRIPTION as source_description,
    DESCRIPTION as condition_description,
    case upper(trim(SYSTEM))
        when 'SNOMED-CT' then 'SNOMED'
        when 'ICD-10-CM' then 'ICD10CM'
        when 'ICD10CM' then 'ICD10CM'
        else upper(trim(SYSTEM))
    end as coding_system
from source
