# YFJ Backend Service

This is the backend service for the YFJ (Your Food Journal) application.

## Prerequisites

- Go 1.21 or later
- Docker and Docker Compose
- MySQL 8.0

## Project Structure

```
backend/
├── cmd/
│   └── server/         # Main application entry point
├── config/             # Configuration files
├── internal/           # Internal application code
│   ├── handler/        # HTTP handlers
│   ├── model/          # Data models
│   ├── repository/     # Data access layer
│   └── service/        # Business logic
├── pkg/                # Reusable packages
│   ├── database/       # Database connection
│   └── logger/         # Logging utilities
└── api/                # API documentation
```

## Getting Started

1. Start the MySQL database:

```bash
docker-compose up -d
```

2. Install dependencies:

```bash
go mod tidy
```

3. Run the application:

```bash
go run cmd/server/main.go
```

The server will start on port 8080 by default.

## API Endpoints

- `POST /api/food/recognize` - Recognize food from an image
- `GET /api/food/:id` - Get food details
- `GET /api/food` - List all foods
- `GET /health` - Health check endpoint

## Configuration

The application can be configured using the `config/config.yaml` file. The following settings are available:

- Server configuration (port, mode)
- Database configuration (host, port, username, password, etc.)
- Logging configuration

## Development

To run tests:

```bash
go test ./...
```

To build the application:

```bash
go build -o bin/server cmd/server/main.go
``` 