# --- Build Stage ---
FROM maven:3.9.6-eclipse-temurin-21 AS build

WORKDIR /app

# Copy local source code to the container
COPY . .

# Build the application
RUN mvn clean package -DskipTests

# --- Runtime Stage ---
FROM openjdk:21-jre-slim

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]