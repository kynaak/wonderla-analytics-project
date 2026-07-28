{{ config(materialized='view') }}

select *
from {{ source('customer', 'CUSTOMERFEEDBACK') }}