# Stage 1: Сборка проекта с Maven
FROM maven:3.8.4-openjdk-17-slim AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Runtime-образ с JRE
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/*.jar /app/jira.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/jira.jar", "--spring.profiles.active=prod"]