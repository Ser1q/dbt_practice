{{
  config(
    materialized = 'table',
    post_hook = '
      {% set backup_relation = api.Relation.create(
        database = this.database,
        schema = this.schema,
        identifier = this.identifier ~ "_dbt_backup_new",
        type = "table"
      )%}

      {% do adapter.drop_relation(backup_relation)%}

      {% do adapter.rename_relation(this, backup_relation)%}
    '
    )
}}
SELECT
  flight_id,
  flight_no::varchar(10) as flight_no,
  scheduled_departure,
  scheduled_arrival,
  departure_airport,
  arrival_airport,
  "status",
  aircraft_code,
  actual_departure,
  actual_arrival,
  'Halo there' as something_new

FROM {{ source('demo_src', 'flights') }}
{% if is_incremental() %}
WHERE
  scheduled_departure > (SELECT MAX(scheduled_departure) FROM {{ source('demo_src', 'flights') }}) - INTERVAL '100 days'
{% endif %}
    