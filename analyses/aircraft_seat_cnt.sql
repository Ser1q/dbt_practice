SELECT 
    aircraft_code,
    COUNT(*) AS number_of_seats
FROM
    {{ ref('stg_flights__seats') }}
GROUP BY 
    aircraft_code

{# CN1
733
SU9
321
319
320
763
773
CR2 #}

