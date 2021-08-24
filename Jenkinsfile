pipeline {
	agent any
	
	environment {

      sonar_url = 'http://172.31.6.111:9000/'
      sonar_username = 'admin'
      sonar_password = 'admin'
      nexusUrl = '172.31.6.111:8081'
      artifact_version = '0.0.1'
		
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
            sh 'git clone https://github.com/Shilpavsqe/game-of-life1.git'
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
	   stage ('Publishing Artifact'){
           steps {
	   nexusArtifactUploader artifacts: [[artifactId:'gameoflife', classifier: '', file: '/var/lib/jenkins/workspace/Test-pipeline/gameoflife-build/target/gameoflife-build-1.0-SNAPSHOT.jar', type: 'jar']], credentialsId: 'c32c6997-d3d3-4ced-b4f3-f2a5fc1f8df3', groupId: 'com.wakaleo.gameoflife', nexusUrl="${nexus_url}", nexusVersion: 'nexus3', protocol: 'http', repository: 'release', version: '4.0.0'
           archiveArtifacts '**/*.jar'
   }
}
   }
}
