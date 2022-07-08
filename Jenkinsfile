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
            post
            {
                success
                {
                    archiveArtifacts artifacts: '**/target/*.jar'
                }
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
