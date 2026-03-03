{{ config(materialized='table', alias='medications') }}

with source as (
    select
        "START",
        "STOP",
        "PATIENT",
        "PAYER",
        "ENCOUNTER",
        "CODE",
        "DESCRIPTION",
        "BASE_COST",
        "PAYER_COVERAGE",
        "DISPENSES",
        "TOTALCOST"
    from {{ ref('medications') }}
)
select
    "PATIENT" as patient_id,
    "ENCOUNTER" as encounter_id,
    cast("START" as date) as drug_exposure_start_date,
    cast("START" as timestamp) as drug_exposure_start_datetime,
    cast("START" as timestamp) as medication_start_ts,
    cast("STOP" as date) as drug_exposure_end_date,
    cast("STOP" as timestamp) as drug_exposure_end_datetime,
    cast("STOP" as timestamp) as medication_end_ts,
    "CODE" as source_code,
    "CODE" as medication_code,
    "DESCRIPTION" as source_description,
    "DESCRIPTION" as medication_description,
    cast("DISPENSES" as float) as quantity,
    cast("BASE_COST" as float) as base_cost,
    cast("TOTALCOST" as float) as total_cost,
    'RXNORM' as source_vocabulary_id
from source
