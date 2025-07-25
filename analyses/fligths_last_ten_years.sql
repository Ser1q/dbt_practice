{%- set current_date = run_started_at | string | truncate(10, True, "") %}
{%- set current_year = (current_date)[:4] | int %}
{%- set prev_year =  current_year - 10 %}
{%- set prev_date =  (prev_year | string) + (current_date[4:]) -%}
-- {{prev_year}}
-- {{(current_date[4:])}}
-- {{prev_date}}
SELECT 
    COUNT(*) as count_last_10_years_flights
FROM 
    {{ ref('fct_flights') }}
WHERE
    scheduled_departure >= '{{prev_date}}'