select *
from {{ source('weather_data', 'TICKETTYPES') }}