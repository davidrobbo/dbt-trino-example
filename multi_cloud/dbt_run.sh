#/bin/bash

# This is a hack - trino inits without schemas, and dbt creates delta schema without location that is required
# Something more elegant required in a prod setup

function query() {
    stmt=$1
    next=$(curl \
      --data "$stmt" \
      -H "X-Trino-User: anyone" \
     http://localhost:8080/v1/statement \
     | jq -r '.nextUri')
    if [ "$next" != "null" ]; then
        while [ "$next" != "null" ]
        do
            echo "Calling $next"
            next=$(curl -H "X-Trino-User: anyone" "$next" | jq -r '.nextUri')
        done
    fi
}

query "CREATE SCHEMA IF NOT EXISTS delta.public_delta WITH (location = 's3a://some-bucket/public_delta.db/')"
query "CALL delta.system.register_table(schema_name => 'public_delta', table_name => 'activity', table_location => 's3a://some-bucket/public_delta.db/activity')"

dbt run --profiles-dir .