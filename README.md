# stackpick-backend

Spring Boot backend API for StackPick, which a curated recommendation platform for movies, games, places, and more.

## Overview

This repository contains the backend API for StackPick. It is built with Spring Boot and runs together with PostgreSQL via Docker Compose.

## Requirements

To run the project locally, you need:

- Docker
- Docker Compose
- Bash
- A Java/Maven setup only if you want to run the application outside of Docker

## Project structure

- `compose.yaml` — Docker Compose configuration for the backend and PostgreSQL
- `start-env.sh` — helper script that selects the environment and starts the stack
- `src/main/resources/` — application configuration
- `src/main/resources/db/migration/` — database migrations

## Running the project

This project is started through a custom script that selects the environment-specific `.env` file, copies it to `.env`, and then starts Docker Compose.

The script expects one of the following files to exist in the repository root:
- `.env.local`
- `.env.stag`
- `.env.prod`

### Start the local environment

```bash
./start-env.sh local
```

### Start the staging environment

```bash
./start-env.sh stag
```

### Start the production environment

```bash
./start-env.sh prod
```

## Manual Docker Compose startup

If you prefer to start the stack manually, you can do so with Docker Compose:

```bash
cp .env.local .env  # or .env.stag, .env.prod
docker compose up --build
```

## Environment variables

The application uses environment variables for configuration. These should be defined in the `.env` file that is selected by the `start-env.sh` script. The expected variables include:
- `SPRING_PROFILES_ACTIVE` — the active Spring profile (e.g., local, stag, prod)
- `POSTGRES_DB` — the JDBC URL for the PostgreSQL database
- `POSTGRES_USER` — the username for the PostgreSQL database
- `POSTGRES_PASSWORD` — the password for the PostgreSQL database

## Ports

When the stack is running:
- The backend API will be available at `http://localhost:8090`
- PostgreSQL will be available at `localhost:5433` (for local development), while the internal Docker network uses `postgres:5432`

## Resetting the database

PostgreSQL data is persisted in a Docker volume named `postgres_data`. To reset the database, you can remove this volume:

```bash
docker compose down -v
```

This will stop the containers and remove the volume, effectively resetting the database to its initial state when you start the stack again.

## Notes

- The backend service depends on PostgreSQL being healthy before it starts. If you encounter issues with the backend not starting, ensure that PostgreSQL is running and healthy.
- If database changes do not appear, the persisted volume may be retaining old data. Use the reset instructions above to clear the database if needed.
- Make sure to have the appropriate `.env` files with the correct configuration for your environment before starting the stack.
- The application configuration is profile-based and is controlled by the `SPRING_PROFILES_ACTIVE` environment variable, which should match the environment you intend to run (local, stag, prod).