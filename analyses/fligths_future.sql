SELECT 
    COUNT(*) as total_future_flights
FROM 
    {{ ref('fct_flights') }}
WHERE 
    scheduled_departure >= '{{ run_started_at | string | truncate(10, True, "")}}'