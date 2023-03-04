#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE USER postgres_telemetry SUPERUSER PASSWORD 'postgres_telemetry';
	CREATE DATABASE postgres_telemetry OWNER postgres_telemetry;
    CREATE DATABASE postgres_people OWNER postgres_telemetry;
    CREATE DATABASE vehicle OWNER postgres_telemetry;
    CREATE DATABASE tracking OWNER postgres_telemetry;
EOSQL

echo "host    all             all             telemetry.xptotracking-infra_ipl      md5" >> /var/lib/postgresql/data/pg_hba.conf
echo "host    all             all             people.xptotracking-infra_ipl         md5" >> /var/lib/postgresql/data/pg_hba.conf
echo "host    all             all             vehicle.xptotracking-infra_ipl        md5" >> /var/lib/postgresql/data/pg_hba.conf
echo "host    all             all             tracking.xptotracking-infra_ipl       md5" >> /var/lib/postgresql/data/pg_hba.conf