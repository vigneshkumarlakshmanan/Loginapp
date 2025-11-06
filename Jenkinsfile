pipeline {
    agent any
       environment {
        DOCKER_HUB_USER = 'vigneshkumarlakshmanan'
        IMAGE_NAME = 'login-app'
    }
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/vigneshkumarlakshmanan/Loginapp.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package -Dmaven.repo.local=/tmp/.m2/repository'
            }
        }
                stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_HUB_USER/$IMAGE_NAME:${BUILD_NUMBER} .'
            }
        }
          stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    sed -i "s|vigneshkumarlakshmanan/flask-login-app:v1|$DOCKER_HUB_USER/$IMAGE_NAME:${BUILD_NUMBER}|g" k8s/deployment.yaml
                    kubectl apply -f k8s/deployment.yaml
                '''
            }
    }
}
}
