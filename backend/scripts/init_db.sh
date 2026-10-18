#!/bin/bash

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL to be ready..."
while ! PGPASSWORD=postgres pg_isready -h postgres -p 5432 -U postgres; do
  sleep 1
done

# Create database if it doesn't exist
echo "Creating database if it doesn't exist..."
PGPASSWORD=postgres psql -h postgres -U postgres -c "CREATE DATABASE yfj;"

# Connect to the database and run migrations
echo "Running migrations..."
PGPASSWORD=postgres psql -h postgres -U postgres -d yfj -f /app/migrations/001_initial_schema.sql
PGPASSWORD=postgres psql -h postgres -U postgres -d yfj -f /app/migrations/002_initial_data.sql

echo "Database initialization completed!" 