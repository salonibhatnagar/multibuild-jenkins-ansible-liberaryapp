pipeline {
   environment {
        registry = "52.149.220.193:8085/library"
        registryCredential = 'nexus-hub'
        dockerImage = ''
    }
    agent any 
    // agent is where my pipeline will be eexecuted
    tools {
        //install the maven version configured as m2 and add it to the path
        maven "mvn1"
    }
    stages {
        stage('pull from scm') {
            steps {
            git credentialsId: 'myprj-git-cred', url: 'https://github.com/salonibhatnagar/jenkins-tomcat-librayapp.git'
            }
        }
        stage('build it') {
            steps {
            sh 'mvn clean package'
            }
        }
        stage('docker image') {
            steps {
                script {
                  dockerImage=docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('docker push') {
            steps {
                script {
                  docker.withRegistry('http://52.149.220.193:8085',registryCredential) {
                      dockerImage.push()
                  }
                }
            }
        }
    }
}
