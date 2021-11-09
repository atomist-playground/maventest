FROM maven:3.5.4-jdk-8-alpine@sha256:72922abc95d38e02f750b34800239dc0e2c298e74bfdd970018367f0d9281d5c as build

COPY ./pom.xml ./src ./

RUN mvn install

FROM openjdk:8u171-jre-alpine

WORKDIR /app

COPY --from=build target/*.jar ./
COPY --from=build target/lib ./lib

ENTRYPOINT ["java", "-jar", "/app/SimpleJavaProject-1.0.jar"]
