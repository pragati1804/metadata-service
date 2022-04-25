##BUILD STAGE
FROM maven AS build
WORKDIR /usr/app
COPY pom.xml /usr/app/pom.xml
COPY src /usr/app/src
RUN mvn clean package

##RUN STAGE
FROM openjdk:alpine
COPY --from=build /usr/app/target/metadata-service.jar .
EXPOSE 8080
ENTRYPOINT java -jar metadata-service.jar