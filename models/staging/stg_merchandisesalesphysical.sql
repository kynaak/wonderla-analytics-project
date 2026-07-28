select *
from {{ source('merchandise_products', 'MERCHANDISESALESPHYSICAL') }}