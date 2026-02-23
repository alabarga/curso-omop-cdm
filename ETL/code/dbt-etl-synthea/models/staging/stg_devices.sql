{{ config(materialized='table', alias='devices') }}

select
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    date(START) as device_start_date,
    datetime(START) as device_start_datetime,
    date(STOP) as device_end_date,
    datetime(STOP) as device_end_datetime,
    CODE as device_code,
    DESCRIPTION as device_description,
    UDI as unique_device_id,
    'SNOMED' as source_vocabulary_id
from {{ ref('devices') }}
