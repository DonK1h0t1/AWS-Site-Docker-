FROM postgres:16
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=admin123
ENV POSTGRES_DB=era_db
COPY init.sql /docker-entrypoint-initdb.d/
