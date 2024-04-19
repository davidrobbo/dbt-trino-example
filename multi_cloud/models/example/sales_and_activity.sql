{{
    config(
        materialized='table',
        catalog='postgres',
        schema='postgres'
    )
}}
WITH activity_by_day_and_type AS (
    SELECT
        page_view_datetime,
        type,
        COUNT(*) AS activity_count
    FROM delta.public_delta.activity --- needs ref'n
    GROUP BY page_view_datetime, type
), sales_by_day_and_type AS (
    SELECT
        transaction_datetime,
        type,
        COUNT(*) AS sales_count,
        SUM(quantity_kg) AS sales_quantity_kg
    FROM {{ ref('sales') }}
    GROUP BY transaction_datetime, type
)
SELECT
   sales_count,
   sales_quantity_kg,
   activity_by_day_and_type.type,
   activity_count,
   transaction_datetime
FROM sales_by_day_and_type
LEFT JOIN activity_by_day_and_type
    ON sales_by_day_and_type.transaction_datetime = activity_by_day_and_type.page_view_datetime
    AND sales_by_day_and_type.type = activity_by_day_and_type.type