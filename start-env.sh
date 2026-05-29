#!/bin/bash

# Validate that an environment argument is provided.
if [ -z "$1" ]; then
  echo "No environment specified. Please provide an environment as an argument (local, stag, prod)."
  exit 1
fi

# Read which environment the user wishes to start from the command line argument.
ENVIRONMENT=$1

# Check if the user passed the --build flag to the script.
if [[ "$2" == "--build" ]]; then
  BUILD_FLAG="--build"
else
  BUILD_FLAG=""
fi

# Validate the environment argument, is it either "local", "stag" or "prod"?
if [[ "$ENVIRONMENT" != "local" && "$ENVIRONMENT" != "stag" && "$ENVIRONMENT" != "prod" ]]; then
  echo "Invalid environment specified. Please choose one of: local, stag, prod."
  exit 1
fi

# Check if the correct .env file exists for the specified environment.
ENV_FILE=".env.$ENVIRONMENT"
if [[ ! -f "$ENV_FILE" ]]; then
  echo "Environment file $ENV_FILE not found. Please create it with the necessary environment variables."
  exit 1
fi

# Copy the specified .env file to .env.
cp "$ENV_FILE" .env

# Start the Docker Compose environment.
docker compose up $BUILD_FLAG
