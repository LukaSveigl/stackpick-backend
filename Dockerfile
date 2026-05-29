# syntax=docker/dockerfile:1.7
FROM maven:3.9-eclipse-temurin-26 AS build

WORKDIR /app

COPY pom.xml ./
COPY .mvn .mvn

RUN mvn dependency:go-offline -B -q -DskipTests

COPY src ./src

RUN mvn clean package -DskipTests -B -q

FROM eclipse-temurin:26-jre

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8090

ENTRYPOINT ["java", "-jar", "app.jar"]