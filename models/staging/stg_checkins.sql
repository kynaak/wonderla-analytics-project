{{ config(materialized='view') }}

select *
from {{ source('customer', 'CHECKINS') }}