pipeline
{
    agent any
    tools 
            {
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
                    file: 'server/target/server.jar',
                    type: 'jar'
                ]
            ], 
            credentialsId: 'chandana',
            groupId: 'com.example.maven-project',
            nexusUrl: '20.210.225.219:8081',
            nexusVersion: 'nexus3',
            protocol: 'http',
            repository: 'maven-repo',
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
        stage('pull artifact')
        {
            steps
            {
                echo 'pulling the artifact from nexus repository....'
                sh'''
                wget --user=admin --password=Zerodha@3005 http://20.210.225.219:8081/repository/maven-repo/com/example/maven-project/maven-project/1.0-SNAPSHOT/maven-project-1.0-20220711.192422-1.jar
                mv maven-project-1.0-20220711.192422-1.jar AzureServer.jar
                '''
            }
        }
        stage('Deploy to Azure')
        {
            steps
            {
                sshagent(['tomcat8'])
                {
                    sh '''
                    scp -o StrictHostKeyChecking=no /workspace/deploy_pipeline/Azureserver.jar azureuser@20.89.135.129:/opt/tomcat8/webapps
                    ssh azureuser@20.89.135.129 /opt/tomcat8/bin/shutdown.sh
                    ssh azureuser@20.89.135.129 /opt/tomcat8/bin/startup.sh
                    '''
                }
            }
        }
    }
}
