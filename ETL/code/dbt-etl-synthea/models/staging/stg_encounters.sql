{{ config(materialized='table', alias='encounters') }}

with source as (
    select
        *,
        datetime(START) as start_ts,
        datetime(STOP) as stop_ts
    from {{ ref('encounters') }}
)
select
    Id as encounter_id,
    PATIENT as patient_id,
    PROVIDER as provider_source_value,
    ORGANIZATION as organization_id,
    PAYER as payer_id,
    date(start_ts) as encounter_start_date,
    start_ts as encounter_start_datetime,
    start_ts as encounter_start_ts,
    date(stop_ts) as encounter_end_date,
    stop_ts as encounter_end_datetime,
    stop_ts as encounter_end_ts,
    lower(trim(ENCOUNTERCLASS)) as encounter_class,
    CODE as source_code,
    CODE as encounter_code,
    'SNOMED' as source_vocabulary_id,
    DESCRIPTION as description,
    cast(BASE_ENCOUNTER_COST as double) as base_cost,
    cast(TOTAL_CLAIM_COST as double) as total_cost,
    cast(PAYER_COVERAGE as double) as payer_coverage,
    REASONCODE as reason_code,
    REASONDESCRIPTION as reason_description
from source
