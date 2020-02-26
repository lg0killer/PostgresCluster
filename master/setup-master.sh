#!/bin/bash
set -e

echo "host replication all 0.0.0.0/0 trust" >> "$PGDATA/pg_hba.conf"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    ALTER ROLE postgres password null;
EOSQL

sed -i 's/md5/trust/g' /var/lib/postgresql/data/pg_hba.conf
