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

COPY wait-for-it.sh /wait-for-it.sh

RUN apk update && apk add --no-cache \
    bash \
    && rm -rf /var/cache/apk/* \
    chmod +x wait-for-it.sh


CMD ["java", "-jar", "app.jar"]
