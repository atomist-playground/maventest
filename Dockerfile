FROM maven:3.5.4-jdk-8-alpine as build

COPY ./pom.xml ./src ./

RUN mvn install

FROM openjdk:8u171-jre-alpine

WORKDIR /app

COPY --from=build target/*.jar ./
COPY --from=build target/lib/*.jar ./lib/

ENTRYPOINT ["java", "-jar", "/app/SimpleJavaProject-1.0.jar"]