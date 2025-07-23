{{
  config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = ['book_ref'],
    tags = ['bookings'],
    incremental_predicates = [
      "DBT_INTERNAL_DEST.session_start > dateadd(day, -7, current_date)"
    ],
    on_schema_change = 'fail'
    )
}}
SELECT
  book_ref,
  book_date,
  total_amount:: int as total_amount,
  1 as some_amount

FROM {{ source('demo_src', 'bookings') }}
{% if is_incremental() %}
WHERE 
  book_date > (SELECT MAX(book_date) FROM {{ source('demo_src', 'bookings') }}) - INTERVAL '97 day'
{% endif %}
    