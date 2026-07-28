select *
from {{ source('customer', 'TICKETSALESPHYSICAL') }}