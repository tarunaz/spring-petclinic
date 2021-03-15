FROM openjdk:8
EXPOSE 8080
ADD target/*.jar spring-petclinic.jar
ENTRYPOINT ["java","-jar","spring-petclinic.jar"] 
