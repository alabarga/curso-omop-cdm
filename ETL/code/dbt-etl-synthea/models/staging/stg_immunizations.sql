{{ config(materialized='table', alias='immunizations') }}

with source as (
    select
        DATE,
        PATIENT,
        ENCOUNTER,
        CODE,
        DESCRIPTION,
        BASE_COST
    from {{ ref('immunizations') }}
)
select
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    date(DATE) as immunization_date,
    datetime(DATE) as immunization_datetime,
    CODE as source_code,
    CODE as immunization_code,
    DESCRIPTION as source_description,
    DESCRIPTION as immunization_description,
    cast(BASE_COST as double) as base_cost,
    'CVX' as source_vocabulary_id
from source
