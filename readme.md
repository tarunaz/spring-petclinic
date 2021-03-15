This project is an example to run an automated build and deployment of a Spring Boot application using Docker and Jenkins

This example runs all components as a docker image

# Prerequisites
To deploy the secured cluster services for the StackRox Kubernetes Security Platform, you must:

Have Docker and Git installed on your machine

## Install Jenkins
If you don't have Jenkins installed, you can build and run a custom Jenkins docker image using the commands below -

```
docker build -t myjenkins-blueocean:1.1 -f jenkins.Dockerfile .

docker run --name jenkins-blueocean  --rm --detach --privileged --publish 80:8080 --publish 50000:50000 --volume /var/run/docker.sock:/var/run/docker.sock  --volume jenkins-data:/var/jenkins_home    --volume "$HOME":/home  --volume ~/.m2:/root/.m2  myjenkins-blueocean:1.1
```

Jenkins can be accessed at http://localhost
Additional details to login and initialize Jenkins can be found <a href=https://www.jenkins.io/doc/tutorials/build-a-java-app-with-maven/#run-jenkins-in-docker>here</a>


## Install Artifactory 

If you don't have Artifactory installed already, you can use the OSS version or sign up for a 30 day trial at JFrog

```
docker volume create artifactory-data

docker run -d --name artifactory --rm -p 8082:8082 -p 8081:8081 -v artifactory-data:/var/opt/jfrog/artifactory releases-docker.jfrog.io/jfrog/artifactory-pro:latest
```

Artifactory can now be accessed at http://localhost:8081


## Steps to create Jenkins Pipeline to build and push docker image to Artifactory:

In this exmaple, we have resolved all dependencies from JCenter. This is achieved by adding the following to your pom.xml.

```
<repository>
  <id>jcenter</id>
  <name>jcenter</name>
  <url>https://jcenter.bintray.com</url>
</repository>
```
Note: List of required Jenkins plugins to build this app

* Artifactory Plugin
* Docker Pipeline Plugin
* GitHub plugin
* Pipeline Github Plugin
* Pipeline Plugin

## Steps

1. From the Jenkins dashboard, create a New Item of type Pipeline. Configure it and pick the Pipeline script from SCM option passing it the Jenkinsfile in this git repo.

2. Add your Artifactory credentials as the type Username with password, with the ID artifactory-credentials (click on Credentials -> System -> Global credentials -> Add Credentials)

3. Configure the artifactory server in Jenkins 

![ScreenShot](https://raw.githubusercontent.com/tarunaz/spring-petclinic/main/images/artifactory_server.png)

4. To build your new Pipeline job, press Build Now. After a few minutes if the build is succesful, you should see something like this on the page of your new Jenkins job

![ScreenShot](https://raw.githubusercontent.com/tarunaz/spring-petclinic/main/images/jenkins.png)

5. You should now see the image appear in your Artifactory repository

![ScreenShot](https://raw.githubusercontent.com/tarunaz/spring-petclinic/main/images/artifactory.png)

6. As well as the build info and matadata info that links your image back to jenkins

![ScreenShot](https://raw.githubusercontent.com/tarunaz/spring-petclinic/main/images/builds.png)




