FROM maven:3.5.4-jdk-8-alpine@sha256:72922abc95d38e02f750b34800239dc0e2c298e74bfdd970018367f0d9281d5c as build

COPY ./pom.xml ./src ./

RUN mvn install

FROM openjdk:8u171-jre-alpine@sha256:e3168174d367db9928bb70e33b4750457092e61815d577e368f53efb29fea48b

WORKDIR /app

COPY --from=build target/*.jar ./
COPY --from=build target/lib/*.jar ./lib/

ENTRYPOINT ["java", "-jar", "/app/SimpleJavaProject-1.0.jar"]