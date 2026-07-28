select *
from {{ source('customer', 'TICKETSALESONLINE') }}