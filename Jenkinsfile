pipeline {
    
    /*agent {
        docker {
            image 'maven:3-alpine' 
            args '-v /root/.m2:/root/.m2' 
        }
    }*/
    
    agent any
    
    stages {
        stage('Build') { 
            steps {
                sh 'mvn -B -DskipTests clean package -Dcheckstyle.skip=true' 
            }
        }

        /*stage('Test') {
            steps {
                sh 'mvn test -Dcheckstyle.skip=true'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }*/
        

        stage('Build image') { // build and tag docker image
       

            steps {
                echo 'Starting to build docker image'

                script {
                    def dockerfile = 'Dockerfile'
                    
                    app = docker.build("docker-local/spring-petclinic", "-f ${dockerfile} .")

                }
            }
        }

        stage ('Push image to Artifactory') { // take that image and push to artifactory
            steps {
                echo 'Starting to push image to Artifactory'

                script {
                    def rtServer = Artifactory.server 'jfrog-eval'
                    def rtDocker= Artifactory.docker server: rtServer
                    def buildInfo = Artifactory.newBuildInfo()
                    
                    /* Finally, we'll push the image with two tags:
                     * First, the incremental build number from Jenkins
                     * Second, the 'latest' tag.
                     * Pushing multiple tags is cheap, as all the layers are reused. */
                    docker.withRegistry('http://veerviaan.net:8081/docker-local/spring-petclinic', 'artifactory-credentials') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                    
                    /*
                    Capture and publish build information to Artifactory
                    */
                    buildInfo.env.collect()
                    rtServer.publishBuildInfo buildInfo

                }
            }
        }
    }
    
}
