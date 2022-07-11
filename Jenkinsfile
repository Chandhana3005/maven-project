pipeline
{
    agent any
    tools {
    maven 'maven'
            }
    stages
    {
        stage('SonarQube Analysis')
        {
            environment {
          // requires SonarQube Scanner 2.8+
                        scannerHome = tool 'mysonarscanner'
                        }
            steps
            {
                withSonarQubeEnv(installationName: 'mysonar', credentialsId: 'sonar-token')
                {
                sh'mvn clean sonar:sonar'
                }
            }
        }
        stage('Quality Gate')
        {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
        }
        stage('Build')
        {
            steps
            {
                sh'mvn package -Dskiptests=true'
            }
           
        }
        stage('Publish to Nexus')
        {
            steps
            {
              nexusArtifactUploader artifacts: 
            [
                [
                    artifactId: 'maven-project',
                    classifier: '',
                    file: 'target/Server.jar',
                    type: 'jar'
                ]
            ], 
            credentialsId: 'chandana',
            groupId: 'com.example.maven-project',
            nexusUrl: '20.210.225.219:8081',
            nexusVersion: 'nexus3',
            protocol: 'http',
            repository: 'http://20.210.225.219:8081/repository/maven-repo',
            version: '1.0-SNAPSHOT'  
            }
        }
        stage('Test')
        {
            steps
            {
                sh'mvn test'
            }
            post
            {
                always
                {
                    junit'**/target/surefire-reports/*.xml'
                }
            }
            
        }
    }
}
