select *
from {{ source('rides', 'MAINTENANCECOSTS') }}