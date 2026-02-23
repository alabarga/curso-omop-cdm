{{ config(materialized='table', alias='medications') }}

with source as (
    select
        START,
        STOP,
        PATIENT,
        PAYER,
        ENCOUNTER,
        CODE,
        DESCRIPTION,
        BASE_COST,
        PAYER_COVERAGE,
        DISPENSES,
        TOTALCOST
    from {{ ref('medications') }}
)
select
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    date(START) as drug_exposure_start_date,
    datetime(START) as drug_exposure_start_datetime,
    datetime(START) as medication_start_ts,
    date(STOP) as drug_exposure_end_date,
    datetime(STOP) as drug_exposure_end_datetime,
    datetime(STOP) as medication_end_ts,
    CODE as source_code,
    CODE as medication_code,
    DESCRIPTION as source_description,
    DESCRIPTION as medication_description,
    cast(DISPENSES as double) as quantity,
    cast(BASE_COST as double) as base_cost,
    cast(TOTALCOST as double) as total_cost,
    'RXNORM' as source_vocabulary_id
from source
