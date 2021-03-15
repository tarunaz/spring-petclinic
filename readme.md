This project is an example to run an automated build and deployment of a Spring Boot application using Docker and Jenkins

This example runs all components as a docker image

# Prerequisites
To deploy the secured cluster services for the StackRox Kubernetes Security Platform, you must:

Have Docker and Git installed on your machine

## Install Jenkins
If you don't have Jenkins installed, you can build and run a custom Jenkins docker image using the commands below -

```
docker build -t myjenkins-blueocean:1.1 -f jenkins.Dockerfile

docker run --name jenkins-blueocean  --rm --detach --privileged --publish 80:8080 --publish 50000:50000 --volume /var/run/docker.sock:/var/run/docker.sock  --volume jenkins-data:/var/jenkins_home   --volume jenkins-docker-certs:/certs/client:ro   --volume "$HOME":/home  --volume ~/.m2:/root/.m2  myjenkins-blueocean:1.1
```

Jenkins can be accessed at http://localhost
Additional details to login and initialize Jenkins can be found <a href=https://www.jenkins.io/doc/tutorials/build-a-java-app-with-maven/#run-jenkins-in-docker>here</a>


## Install Artifactory 

```
docker volume create artifactory-data

docker run -d --name artifactory --rm -p 8082:8082 -p 8081:8081 -v artifactory-data:/var/opt/jfrog/artifactory releases-docker.jfrog.io/jfrog/artifactory-pro:latest
```

Artifactory can be accessed at http://localhost:8081


## Steps to create Jenkins Pipeline to build and push docker image to Artifactory:
Note: List of required Jenkins plugins

* Artifactory Plugin
* Docker Pipeline Plugin
* GitHub plugin
* Pipeline Github Plugin
* Pipeline Plugin

1. On the Jenkins front page, click on Credentials -> System -> Global credentials -> Add Credentials

2. Add your Artifactory credentials as the type Username with password, with the ID artifactory-credentials

3. Create new Jenkins Pipeline Job.

4. Use the option to get Jenkinsfile from SCM

5. To build it, press Build Now. After a few minutes you should see an image appear in your Artifactory repository, and something like this on the page of your new Jenkins job



