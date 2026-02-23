{{ config(materialized='table', alias='payer_transitions') }}

select
    PATIENT as patient_id,
    MEMBERID as member_id,
    date(START_DATE) as start_date,
    date(END_DATE) as end_date,
    PAYER as payer_id,
    SECONDARY_PAYER as secondary_payer_id,
    PLAN_OWNERSHIP as plan_ownership,
    OWNER_NAME as owner_name
from {{ ref('payer_transitions') }}
