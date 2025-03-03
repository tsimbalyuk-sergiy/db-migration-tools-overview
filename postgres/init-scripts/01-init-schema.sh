#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE SCHEMA IF NOT EXISTS template_service;
    CREATE SCHEMA IF NOT EXISTS audit;
    ALTER DATABASE $POSTGRES_DB SET search_path TO template_service, public;

    CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    GRANT ALL PRIVILEGES ON SCHEMA template_service TO $POSTGRES_USER;
    GRANT ALL PRIVILEGES ON SCHEMA audit TO $POSTGRES_USER;
EOSQL

echo "postgresql initialized with template_service and audit schemas"