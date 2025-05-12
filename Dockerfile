
# --- Build Stage ---
# Use an image that has JDK and Maven (or Gradle if you use that)
FROM maven:3.9.6-eclipse-temurin-21 AS build

# Set the working directory
WORKDIR /app

# Argument for the GitHub repository URL
ARG GITHUB_REPO_URL
# Argument for the branch or tag to checkout (optional, defaults to main/master)
ARG GITHUB_BRANCH=main

# Clone the repository
# You might need to install git if the base image doesn't have it
# RUN apt-get update && apt-get install -y git # Uncomment if git is not in maven image
RUN git clone --branch ${GITHUB_BRANCH} ${GITHUB_REPO_URL} .

# Build the application
# If your pom.xml is in a subdirectory, adjust the command accordingly
RUN mvn clean package -DskipTests

# --- Runtime Stage ---
# Use a slim JRE image for the final image
FROM openjdk:21-jre-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
# Adjust the path if your JAR is named differently or in a different subfolder of target
COPY --from=build /app/target/*.jar app.jar

# Expose the port the application runs on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]


# The way to build docker image from local machine while code is on github repo
# docker build \
#     --build-arg GITHUB_REPO_URL=https://github.com/your-github-username/your-repository-name.git \
#     --build-arg GITHUB_BRANCH=main \
#     -t your-dockerhub-username/my-spring-app-from-github .