#!/usr/bin/env bash
set -e
shopt -s nullglob

/opt/mssql/bin/sqlservr &
pid=$!

echo "Waiting for SQL Server..."
until /opt/mssql-tools18/bin/sqlcmd \
  -S localhost -U sa -P "YourStrong!Passw0rd" \
  -Q "SELECT 1" -C >/dev/null 2>&1
do
  sleep 2
done

echo "SQL Server is ready."

for f in /docker-entrypoint-initdb.d/*.sql; do
  echo "Running $f"
  /opt/mssql-tools18/bin/sqlcmd \
    -S localhost \
    -U sa \
    -P "YourStrong!Passw0rd" \
    -d master \
    -i "$f" \
    -C
  echo "Completed $f"
done

wait $pid
