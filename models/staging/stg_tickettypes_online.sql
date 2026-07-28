select *
from {{ source('ticket_types', 'TICKETSALESONLINE') }}