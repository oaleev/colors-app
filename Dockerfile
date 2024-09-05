# Stage 1: Build the application
FROM maven:3.9.5-eclipse-temurin-17 AS builder

# Set the working directory
WORKDIR /app

# Copy the Maven project files to the container
COPY pom.xml .

# Download Maven dependencies (done separately to leverage Docker cache)
RUN mvn dependency:go-offline

# Copy the rest of the application source code to the container
COPY src ./src

# Build the Spring Boot application
RUN mvn clean package -DskipTests

# Stage 2: Create a lightweight runtime image
FROM eclipse-temurin:17-jre-alpine

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set working directory
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/button-demo-0.0.1-SNAPSHOT.jar app.jar

# Change ownership to the non-root user
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
