# Stage 1: Build stage
FROM maven:3.8.4-jdk-8-slim AS build
COPY . /app
WORKDIR /app
RUN mvn clean package

# Stage 2: Runtime stage
FROM openjdk:8-jre-slim
WORKDIR /app
COPY --from=build /app/target/words.jar /app/words.jar
CMD ["java", "-Xmx8m", "-Xms8m", "-jar", "/app/words.jar"]
