{% set status_query%}

SELECT DISTINCT
    "status"
FROM 
    {{ ref('stg_flights__flights') }}

{% endset%}

{% set status_list = run_query(status_query)%}
{% if execute %}
    {% set all_status = status_list.columns[0].values() %}
{% else %}
    {% set all_status = [] %}
{% endif %}

SELECT 
    {% for s in all_status %}
    COUNT(CASE WHEN status = '{{ s }}' THEN 1 ELSE 0 END) AS status_{{s | replace(" ", "_") | lower}}
        {%- if not loop.last %},{% endif %}
        -- {{loop.previtem}}
    {%- endfor %}
FROM
    {{ ref('stg_flights__flights') }}