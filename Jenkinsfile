pipeline {
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
        stage('mvn build') {
            steps {
            sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
            post {
                //if maven build was able to run the test we will create a test report and archive the jar in local machine
                success {
                    junit '**/target/surefire-reports/*.xml'
                    archiveArtifacts 'target/*.jar'
                }
            }
        }
        stage('checkstyle') {
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
        }
         stage('checkstyle Report') {
            steps {
                recordIssues(tools: [checkStyle(pattern: 'target/checkstyle-result.xml')])
            }
        }
        stage('code coverage') {
            steps {
                jacoco()
            }
        }
        stage('sonar scanner') {
            steps {
           sh 'mvn clean verify sonar:sonar -Dsonar.projectKey=library-management-app -Dsonar.host.url=http://13.92.117.147:9000 -Dsonar.login=sqp_4a16dea97bba7e3b89e8a04ac3d03b4723e4fa39'
            }
        }
                stage ('Nexus upload')  {
          steps {
          nexusArtifactUploader(
          nexusVersion: 'nexus3',
          protocol: 'http',
          nexusUrl: '52.149.220.193:8081',
          groupId: 'librarymanagementsystem',
          version: '0.0.1-SNAPSHOT',
          repository: 'maven-snapshots',
          credentialsId: 'nexus',
          artifacts: [
            [artifactId: 'librarymanagementsystem',
             classifier: '',
             file: 'target/librarymanagementsystem-0.0.1-SNAPSHOT.jar',
             type: 'jar']
        ]
        )
          }
     }
    }
}
