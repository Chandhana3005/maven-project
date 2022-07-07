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
       /*/ stage('SonarQube Analysis')
        {
            steps
            {
                withSonarQubeEnv('mysonar')
                sh'mvn sonar:sonar'
            }
        }/* */
        stage('Build')
        {
            steps
            {
                withSonarQubeEnv('mysonar')
                sh'mvn clean package sonar:sonar -Dskiptests=true'
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
