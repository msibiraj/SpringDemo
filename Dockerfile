# Use latest Maven with Eclipse Temurin JDK 21 for build stage
FROM maven:3.9.7-eclipse-temurin-21 AS build

WORKDIR /app

# Copy and download dependencies first (for better caching)
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source code and build the project (skip tests for faster build)
COPY src ./src
RUN mvn clean package -DskipTests

# Use matching JDK 21 (not 17) for runtime for consistency
FROM eclipse-temurin:21-jdk-jammy as runtime

WORKDIR /app

# Copy built JAR from build stage
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar .

# Expose application port
EXPOSE 8080

# Set entrypoint to run the app
ENTRYPOINT ["java", "-jar", "demo-0.0.1-SNAPSHOT.jar"]
