pipeline
{
    agent {label'linuxvm019_slave1'}
    parameters {
    string defaultValue: 'rhelvm', name: 'server_environment'
                }
    tools {
    maven 'maven'
            }
    stages
    {
        stage('Build')
        {
            steps
            {
                sh'mvn clean package -Dskiptests=true'
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
