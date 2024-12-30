pipeline {
    agent any

    environment {
        GIT_CREDENTIALS_ID = 'github-qing161'
    }
    stages {
        stage('Checkout') {
            steps {
                script {
            
                    git branch: 'dev', url: 'https://github.com/Qing161/test1030.github.io', credentialsId: env.GIT_CREDENTIALS_ID
                    
                    def tagName = sh(returnStdout: true, script: 'git describe --tags --abbrev=0').trim()
                    echo "Latest tag is ${tagName}"

                    env.LATEST_TAG = tagName
                    
                }
            }
        }
        
    }
}
