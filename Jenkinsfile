pipeline {
    agent any
    environment {
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
                sh """
                    docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:${BUILD_NUMBER} .
                    echo "${DOCKER_HUB_PSW}" | docker login -u "${DOCKER_HUB_USR}" --password-stdin
                    docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:${BUILD_NUMBER}
                    docker logout
                """
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

