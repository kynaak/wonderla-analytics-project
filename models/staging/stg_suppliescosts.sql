select *
from {{ source('rides', 'SUPPLIESCOSTS') }}