pipeline {
    agent any
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/vigneshkumarlakshmanan/Loginapp.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
    }
}
