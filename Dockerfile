# ----------- Stage 1: Build the Java Application ------------
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Set working directory inside container
WORKDIR /app

# Copy all source code and pom files
COPY . .

# Build the entire Maven project and skip tests
RUN mvn clean package -DskipTests

# ----------- Stage 2: Create a Smaller Runtime Image --------
FROM eclipse-temurin:17-jdk-jammy

# Set working directory
WORKDIR /app

# Copy the final JAR from the builder stage
# Update this path to your main module's JAR if needed
COPY --from=builder /app/page-object-pattern/target/page-object-pattern-1.0-SNAPSHOT.jar app.jar

# Expose the port your app runs on (update if different)
EXPOSE 8080

# Set entrypoint to run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
