pipeline {
    agent any
    environment {
        DOCKER_HUB= credentials('docker-hub-cred')
        DOCKER_HUB_USER = 'vigneshkumar56'
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

        stage('Build & Push Docker Image') {
            steps {
withCredentials([usernamePassword(credentialsId: 'docker-hub-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PSW')]) {
    sh """
        export DOCKER_CONFIG=\$(pwd)/.docker
        mkdir -p \$DOCKER_CONFIG
        docker build -t \$DOCKER_USER/login-app:${BUILD_NUMBER} .
        echo "\$DOCKER_PSW" | docker login -u "\$DOCKER_USER" --password-stdin
        docker push \$DOCKER_USER/login-app:${BUILD_NUMBER}
        docker logout
    """
}

            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh """
                    export KUBECONFIG=/var/lib/jenkins/.kube/config
                    sed -i "s|${DOCKER_HUB_USER}/${IMAGE_NAME}:v1|${DOCKER_HUB_USER}/${IMAGE_NAME}:${BUILD_NUMBER}|g" k8s/deployment.yaml
                    kubectl apply -f k8s/deployment.yaml
                """
            }
        }
    }
}

