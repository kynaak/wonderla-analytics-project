select *
from {{ source('rides', 'CHECKINS') }}