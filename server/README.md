# Portal Server

## Prerequisites
- Java 25
- Docker
- Gradle 9.x

## Getting Started

### 1. Start PostgreSQL Database

Run the PostgreSQL database using Docker:
```bash
docker run -p 5432:5432 \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_DB=postgres \
  postgres:18.1
```

**Database Details:**
- Host: `localhost`
- Port: `5432`
- Database: `postgres`
- Username: `postgres`
- Password: `postgres`

### 2. Run the Application
```bash
./gradlew bootRun
```

Or build and run the JAR:
```bash
./gradlew build
java -jar build/libs/portal-0.0.1.jar
```

### 3. Access the Application

The application will start on `http://localhost:8080`

## Development

### Run Tests
```bash
./gradlew test
```

### Build
```bash
./gradlew build
```

## Database Migrations

This project uses Flyway for database migrations. Migrations run automatically on application startup.

## Configuration

Application configuration can be found in `src/main/resources/application.properties`

## License

See [LICENSE](../LICENSE) for details.