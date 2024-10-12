# Step 1: Use an official Java 21 runtime as the base image
FROM amazoncorretto:21-alpine

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the JAR file of the Spring Boot application into the container
COPY target/*.jar /app/app.jar

# Step 4: Expose the port that Spring Boot uses (8080 by default)
EXPOSE 8080

# Step 5: Define the command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
