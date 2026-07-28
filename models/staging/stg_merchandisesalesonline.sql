select *
from {{ source('merchandise_products', 'MERCHANDISESALESONLINE') }}