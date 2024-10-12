# Step 1: Use Maven to build the application
FROM maven:3.9.9-amazoncorretto-21 AS builder

# Set the working directory in the build container
WORKDIR /app

# Copy the pom.xml file and download project dependencies (caching dependencies)
COPY pom.xml .

# Download dependencies
RUN mvn dependency:go-offline -B

# Copy the entire project
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Step 2: Create the final image using Amazon Corretto 21
FROM amazoncorretto:21-alpine

# Set the working directory in the runtime container
WORKDIR /app

# Copy the JAR file from the builder stage to the runtime container
COPY --from=builder /app/target/*.jar /app/app.jar

# Expose the port that Spring Boot uses (8080 by default)
EXPOSE 8080

# Define the command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
