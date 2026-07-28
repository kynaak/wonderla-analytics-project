select *
from {{ source('rides', 'STAFFCOSTS') }}