pipeline
{
    agent any
    stages
    {
        stage('Build')
        {
            steps
            {
                -B -DskipTests=true
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
