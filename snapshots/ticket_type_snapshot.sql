{% snapshot ticket_type_snapshot %}

{{
    config(
        target_schema='SNAPSHOTS',
        unique_key='ticket_id',
        strategy='timestamp',
        updated_at='updated_at'
    )
}}

select
    ticket_id,
    ticket_type_name,
    description,
    price,
    includes_fast_pass,
    includes_vip_benefits,
    launch_date,
    created_at,
    updated_at
from {{ ref('dim_ticket_types') }}

{% endsnapshot %}