select
    checkin_id,
    customer_id,
    ticket_id,
    haunted_house_id,
    checkin_date,
    checkin_time,
    checkin_timestamp,
    queue_length,
    estimated_wait_minutes,
    actual_wait_minutes,
    wait_accuracy,
    is_peak_hour
from {{ ref('stg_checkins') }}