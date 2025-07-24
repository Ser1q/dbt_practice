SELECT 
    scheduled_departure::date as scheduled_departure,
    COUNT(*) as cancelled_flights
FROM 
    {{ ref('fct_flights') }}
WHERE 
    departure_airport = 'MJZ' 
    AND "status" = 'Cancelled' 
GROUP BY
    scheduled_departure::date
-- MJZ