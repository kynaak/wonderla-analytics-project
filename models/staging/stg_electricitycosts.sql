select *
from {{ source('rides', 'ELECTRICITYCOSTS') }}
