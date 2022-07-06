FROM openjdk:11
MAINTAINER saloni bhatnagar<saloni@gmail.com>
VOLUME /tmp
EXPOSE 8080
ARG JAR_FILE=target/librarymanagementsystem-0.0.1-SNAPSHOT.jar
ADD ${JAR_FILE} librarymanagementsystem.jar
ENTRYPOINT ["java","-jar","/librarymanagementsystem.jar"]
