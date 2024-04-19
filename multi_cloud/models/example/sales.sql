--- In essence, this is a seed, as seeds don't seem configurable per catalog
--- RE schema below, dbt concats profiles.target and this value - could use a macro to overwrite that behaviour
{{
    config(
        materialized='table',
        catalog='sqlserver',
        schema='sqlserver'
    )
}}
SELECT '2024-01-01 00:00:00' AS transaction_datetime, 'MARIS_PIPER' AS type, 100 AS quantity_kg
UNION ALL
SELECT '2024-01-02 00:00:00' AS transaction_datetime, 'KING_EDWARD' AS type, 50 AS quantity_kg