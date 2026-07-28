select *
from {{ source('ticket_types', 'PHYSICALTICKETSALES') }}