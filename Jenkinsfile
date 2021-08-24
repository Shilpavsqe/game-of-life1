pipeline {
   agent any
    environment {

      sonar_url = 'http://172.31.6.111:9000/'
      sonar_username = 'admin'
      sonar_password = 'admin'
 }
    tools {
      // Install the Maven version configured as "M3" and add it to the path.
	  jdk 'Java8'
      maven "Maven3.3.9"
   }
   
   stages
   {
   stage('git clone') {
         steps {
            // Get some code from a GitHub repository
            git 'https://github.com/Shilpavsqe/game-of-life1.git'
        }  
      }
	stage ('Compile and Build') {
         steps {
           sh 'mvn clean install -U  -Dmaven.test.skip=true'
         }
	}
  stage ('Sonarqube Analysis'){
           steps {
           withSonarQubeEnv('sonarqube') {
           sh '''
	   mvn clean package org.jacoco:jacoco-maven-plugin:prepare-agent install -Dmaven.test.failure.ignore=false
           mvn -e -B sonar:sonar -Dsonar.java.source=1.8 -Dsonar.host.url="${sonar_url}" -Dsonar.login="${sonar_username}" -Dsonar.password="${sonar_password}" -Dsonar.sourceEncoding=UTF-8
           '''
           }
         }
      }
      stage ('Publishing Artifact') {
	steps {
	nexusArtifactUploader artifacts: [[artifactId:'gameoflife', classifier: '', file: '/var/lib/jenkins/workspace/Test-pipeline/gameoflife-build/target/gameoflife-build-1.0-SNAPSHOT.jar', type:'jar', type: 'jar']], credentialsId: '25e8f6b2-8c1e-49b9-9f7b-485c40a57b82', groupId: 'com.wakaleo.gameoflife', nexusUrl: '172.31.6.111:8081/', nexusVersion: 'nexus3', protocol: 'http', repository: 'Shilpa', version: '4.0.0'
           archiveArtifacts '**/*.jar'
	}
     }
  }
}
