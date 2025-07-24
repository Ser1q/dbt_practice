{% snapshot dim_flights__airports %}

{{
   config(
       target_schema='snapshot',
       unique_key='airport_code',

       strategy='check',
       check_cols=['airport_name', 'city', 'coordinates', 'timezone'],
       dbt_valid_to_current="'9999-01-01'::date"
   )
}}

SELECT
    airport_code,
    airport_name,
    city,
    coordinates,
    timezone
FROM 
    {{ ref('stg_flights__airports') }}

{% endsnapshot %}