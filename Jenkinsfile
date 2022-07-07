pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mvn1"
    }

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/salonibhatnagar/jenkins-tomcat-librayapp.git'

                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    junit '**/target/surefire-reports/TEST-*.xml'
                    archiveArtifacts 'target/*.jar'
                }
            }
            
               
        }
        stage('ansible deploy') {
           steps {
                // Get some code from a GitHub repository
                ansiblePlaybook credentialsId: 'jenkins-ansible', disableHostKeyChecking: true, inventory: 'dev.inv', playbook: 'tomcat.yml'

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            } 
        }
        stage("deploy-jar"){
            steps{
            sshagent(['jenkins-ansible']) {
               sh """
               scp -o StrictHostKeyChecking=no target/librarymanagementsystem-0.0.1-SNAPSHOT.jar root@tomcat:/opt/tomcat10/i/webapps
               ssh root@tomcat opt/tomcat10/i/bin/shutdown.sh
               ssh root@tomcat opt/tomcat10/i/bin/startup.sh
               """
           }
      }
}
        }
    }

