FROM eclipse-temurin:21-jre

# Set the working directory in the container
WORKDIR /app

# Copy the executable JAR file from your host to the container's working directory
# Replace 'your-app-name-0.0.1-SNAPSHOT.jar' with the actual name of your JAR file
COPY target/spring-boot-docker-0.0.1-SNAPSHOT.jar app.jar

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]