# Template Service with Database Migrations

A minimal proof-of-concept system with three separate components:

1. Postgresql database
2. Database migration service (using either Liquibase or Flyway)
    - Supports three migration approaches: Liquibase YAML, Liquibase SQL, or Flyway SQL
3. Template web service

## Project Structure

```
db-migration-tools-overview/
├── docker-compose-liquibase.yml
├── docker-compose-liquibase-sql.yml
├── docker-compose-flyway.yml
├── postgres/
├── liquibase/
├── liquibase-sql/
├── flyway/
├── service/
└── README.md
```

## Components

### 1. Postgresql Database (postgres/)

Standalone Postgresql database with custom configuration.

### 2. Database Migrations

The project supports two migration tools:

#### Liquibase (migrations/)

Uses YAML format for migrations with a schema-driven approach.

#### Liquibase SQL (liquibase-sql/)

Uses SQL format for migrations with embedded changeset metadata.

#### Flyway (flyway/)

Uses plain SQL migrations with a naming convention-based approach.

### 3. Template Service (service/)

web service that:

- Waits for both the database and migrations to be complete
- Provides a web interface for managing templates
- Allows creating, viewing, and rendering templates
- Generates PDFs from templates

## Running with Docker Compose

The `docker-compose-*.yml` file orchestrates all three services (different per each tool)

#### start

```bash
# Using Liquibase
docker-compose -f docker-compose-liquibase.yml up --build

# Using Flyway
docker-compose -f docker-compose-flyway.yml up --build

# Using Liquibase SQL
docker-compose -f docker-compose-liquibase-sql.yml up --build
```

#### access app

open http://localhost:8080

#### shutdown and cleanup

```bash
# For Liquibase
docker-compose -f docker-compose-liquibase.yml down -v && docker volume prune -f

# For Flyway
docker-compose -f docker-compose-flyway.yml down -v && docker volume prune -f

# For Liquibase SQL
docker-compose -f docker-compose-liquibase-sql.yml down -v && docker volume prune -f
```

## Development

1. Run just the database:
   ```bash
   docker-compose up -d postgres
   ```

2. Run migrations:
   ```bash
   cd migrations
   ./scripts/liquibase-api.sh migrate dev
   ```

3. Run the service locally:
   ```bash
   cd service
   go run main.go
   ```

## License

i have no idea