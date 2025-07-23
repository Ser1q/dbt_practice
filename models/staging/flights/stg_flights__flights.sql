{{
  config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = ['flight_id']
    )
}}
SELECT
  flight_id,
  flight_no,
  scheduled_departure,
  scheduled_arrival,
  departure_airport,
  arrival_airport,
  "status",
  aircraft_code,
  actual_departure,
  actual_arrival

FROM {{ source('demo_src', 'flights') }}
{% if is_incremental() %}
WHERE
  scheduled_departure > (SELECT MAX(scheduled_departure) FROM {{ source('demo_src', 'flights') }}) - INTERVAL '100 days'
{% endif %}
    