{% snapshot dim_aircraft_seats %}

{{
   config(
       target_schema='snapshot',
       unique_key='aircraft_code',

       strategy='check',
       check_cols=['seat_no', 'fare_conditions']
   )
}}

SELECT
    aircraft_code,
    seat_no,
    fare_conditions
FROM
    {{ ref('stg_flights__seats') }}

{% endsnapshot %}