select *
from {{ source('weather_data', 'CHECKINS') }}