select *
from {{ source('rides', 'SAFETYINCIDENTS') }}