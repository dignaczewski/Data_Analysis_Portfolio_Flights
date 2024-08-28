CREATE SCHEMA reporting;

CREATE OR REPLACE VIEW reporting.flight AS
SELECT 
    *,
    CASE 
        WHEN dep_delay_new > 15 THEN 1
        ELSE 0
    END AS is_delayed
FROM 
    flight
WHERE 
    cancelled = 0;

CREATE OR REPLACE VIEW reporting.top_airports_by_departure AS
WITH dep_stat AS (
    SELECT
        origin_airport_id AS origin_airport_id,
        COUNT(is_delayed) AS total_departures,
        SUM(is_delayed) AS delayed_departures
    FROM
        reporting.flight
    GROUP BY
        origin_airport_id
),
arr_stat AS (
    SELECT
        dest_airport_id AS dest_airport_id,
        COUNT(dest_airport_id) AS total_arrivals
    FROM
        reporting.flight
    GROUP BY
        dest_airport_id
)
SELECT
    d.origin_airport_id,
    d.total_departures,
    d.delayed_departures,
    a.total_arrivals,
    ROUND((d.delayed_departures * 1.0 / d.total_departures), 4) AS delay_percentage
FROM
    dep_stat AS d
JOIN arr_stat AS a ON d.origin_airport_id = a.dest_airport_id
ORDER BY
    delay_percentage DESC
LIMIT 10;


CREATE OR REPLACE VIEW reporting.top_reliability_roads AS
WITH cte AS(
SELECT
    origin_airport_id,
    dest_airport_id,
    year,
    COUNT(*) AS total_flights,
    SUM(is_delayed) AS delayed_flights,
    ROUND(SUM(is_delayed) * 1.0/ COUNT(*), 4) AS delay_percentage
FROM
    reporting.flight
GROUP BY
    origin_airport_id, dest_airport_id, year
HAVING
    COUNT(*) >= 10000
)
SELECT
    c.origin_airport_id,
    ao.display_airport_name AS origin_airport_name,
    c.dest_airport_id,
    ad.display_airport_name AS dest_airport_name,
    c.year,
    c.total_flights AS cnt,
    c.delay_percentage AS reliability,
    DENSE_RANK() OVER (ORDER BY c.delay_percentage DESC) AS nb
FROM
    cte AS c
LEFT JOIN airport_list AS ao ON c.origin_airport_id = ao.origin_airport_id
LEFT JOIN airport_list AS ad ON c.dest_airport_id = ad.origin_airport_id
ORDER BY
    c.delay_percentage DESC;


CREATE OR REPLACE VIEW reporting.year_to_year_comparision AS
SELECT
    year,
    month,
    COUNT(*) AS flights_amount,
    ROUND(SUM(is_delayed) * 1.0/ COUNT(*), 4) AS reliability
FROM
    reporting.flight
GROUP BY
    year, month;
    


CREATE OR REPLACE VIEW reporting.day_to_day_comparision AS
SELECT
    year,
    day_of_week,
    COUNT(*) AS flights_amount,
    ROUND(SUM(is_delayed) * 1.0/ COUNT(*), 4) AS reliability
FROM
    reporting.flight
GROUP BY
    year, day_of_week;

CREATE OR REPLACE VIEW reporting.day_by_day_reliability AS
WITH calculation AS (
SELECT
    year::text,
    LPAD(month::text, 2, '0') AS month,
    LPAD(day_of_month::text, 2, '0') AS day_of_month,
    COUNT(*) AS flights_amount,
    ROUND(SUM(is_delayed) * 1.0/ COUNT(*), 4) AS reliability
FROM
    reporting.flight
GROUP BY
    year, month, day_of_month
)
SELECT
    to_date(year || '-' || month || '-' || day_of_month, 'YYYY-MM-DD') AS date,
    reliability
FROM
    calculation