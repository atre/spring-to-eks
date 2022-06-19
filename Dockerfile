FROM maven:latest
COPY code /code
WORKDIR /code
EXPOSE 8080
RUN unset MAVEN_CONFIG && ./mvnw package
CMD unset MAVEN_CONFIG && ./mvnw spring-boot:run
