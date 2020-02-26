#!/bin/bash
if [ ! -s "$PGDATA/PG_VERSION" ]; then

until pg_basebackup -h master-db -D ${PGDATA} -U postgres -vP -W
    do
        echo "Waiting for master to connect..."
        sleep 1s
done

cp /etc/postgresql/postgresql.conf ${PGDATA}/postgresql.conf

touch ${PGDATA}/standby.signal

chown postgres. ${PGDATA} -R
chmod 700 ${PGDATA} -R
fi
sed -i 's/wal_level = hot_standby/wal_level = replica/g' ${PGDATA}/postgresql.conf 

exec "$@"
