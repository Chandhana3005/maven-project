pipeline
{
    agent any
    stages
    {
        stage('Build')
        {
            steps
            {
                -B -Dskiptests=true
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
