{{
  config(
    materialized = 'table',
    )
}}
SELECT
    city,
    region,
    updated_at
FROM
    {{ ref('city_region') }}