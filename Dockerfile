# AS <NAME> to name this stage as maven
FROM maven:3.6.3 AS build

WORKDIR /usr/src/app
COPY . /usr/src/app
# Compile and package the application to an executable JAR
RUN mvn package

# For Java 11,
FROM adoptopenjdk/openjdk11:alpine-jre

ARG JAR_FILE=cardatabase.jar

WORKDIR /opt/app

# Copy the spring-boot-api-tutorial.jar from the maven stage to the /opt/app directory of the current stage.
COPY --from=maven /usr/src/app/target/${JAR_FILE} /opt/app/

ENTRYPOINT ["java","-jar","cardatabase.jar"]
