FROM postgres:latest

RUN echo "host replication all 0.0.0.0/0 md5" >> "$PGDATA/pg_hba.conf"

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["gosu", "postgres", "postgres"]
