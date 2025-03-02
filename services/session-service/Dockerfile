FROM maven:3.8.4-jdk-8 AS builder

LABEL version="1.0" maintainer="le0ruslan@mail.ru"

WORKDIR /app

COPY pom.xml mvnw .mvn/ /app/
RUN mvn -B dependency:go-offline

COPY src /app/src
RUN mvn -B package -DskipTests

FROM openjdk:8-jdk-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]
