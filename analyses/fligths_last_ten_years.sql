{%- set current_date = run_started_at | string | truncate(10, True, "") %}
{%- set current_year = (current_date)[:4] | int %}
{%- set prev_year =  current_year - 10 %}
{%- set prev_date =  (prev_year | string) + (current_date[4:]) -%}
-- {{prev_year}}
-- {{(current_date[4:])}}
-- {{prev_date}}
SELECT 
    COUNT(*) as {{ adapter.quote('count_last_10_years_flights' )}}
FROM 
    {{ ref('fct_flights') }}
WHERE
    scheduled_departure >= '{{prev_date}}'

{% set fct_flights = api.Relation.create(
    database = "dwh_flights",
    schema = "intermediate",
    identifier = "fct_flights",
    type = "table"
)%}

{% set stg_flights__flights = api.Relation.create(
    database = "dwh_flights",
    schema = "intermediate",
    identifier = "stg_flights__flights",
    type = "table"
)%}

{% do adapter.expand_target_column_types(stg_flights__flights, fct_flights) %}

{% for column in adapter.get_columns_in_relation(stg_flights__flights) %}
    {{'Columns: ' ~ column}} 
{% endfor %} 

{% for column in adapter.get_columns_in_relation(fct_flights) %}
    {{'Columns: ' ~ column}} 
{% endfor %} 
--