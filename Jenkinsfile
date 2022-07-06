pipeline
{
    agent any
    stages
    {
        stage('Build')
        {
            steps
            {
                sh'mvn clean package'
            }
            post
            {
                success
                {
                    archiveArtifacts artifacts: '$WORKSPACE/target/*.jar'
                }
            }
        }
    }
}
