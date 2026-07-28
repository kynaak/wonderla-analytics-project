select *
from {{ source('weather_data', 'OPERATINGCOSTS') }}