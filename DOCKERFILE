FROM openjdk:8
WORKDIR /home
COPY **/target/*.jar application.jar
EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "application.jar" ]
