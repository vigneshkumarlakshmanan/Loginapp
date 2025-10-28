pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/yourusername/your-repo.git'   // 🔹 Replace with your repo URL
        BRANCH   = 'main'                                            // 🔹 Branch name
        MAVEN_HOME = tool name: 'Maven', type: 'maven'               // Jenkins tool configuration
        DEPLOY_SERVER = 'ec2-user@10.0.1.50'                         // 🔹 Replace with your test server IP
        DEPLOY_PATH = '/var/www/html/testapp'                        // 🔹 Deployment directory on remote
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo 'Pulling source code from GitHub...'
                git branch: "${BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Build with Maven') {
            steps {
                echo 'Building application...'
                sh "${MAVEN_HOME}/bin/mvn clean package -DskipTests=false"
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo 'Running unit tests...'
                sh "${MAVEN_HOME}/bin/mvn test"
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }

        stage('Deploy to Test Server') {
            steps {
                echo 'Deploying application to test server...'
                // 🔹 Ensure Jenkins has SSH key access to the remote server
                sh '''
                scp -o StrictHostKeyChecking=no target/*.jar ${DEPLOY_SERVER}:${DEPLOY_PATH}/
                ssh -o StrictHostKeyChecking=no ${DEPLOY_SERVER} 'sudo systemctl restart testapp'
                '''
            }
        }
    }

    post {
        success {
            emailext(
                subject: "✅ Jenkins Build Successful: ${JOB_NAME} #${BUILD_NUMBER}",
                body: """
                Hello Vigneshkumar,<br><br>
                The Jenkins build for <b>${JOB_NAME} #${BUILD_NUMBER}</b> completed successfully.<br><br>
                <b>Git Repository:</b> ${GIT_REPO}<br>
                <b>Branch:</b> ${BRANCH}<br>
                <b>Deployed To:</b> ${DEPLOY_SERVER}<br><br>
                Check build logs here: <a href="${BUILD_URL}">${BUILD_URL}</a><br><br>
                Regards,<br>
                Jenkins CI/CD
                """,
                to: 'vigneshkumar5eee@gmail.com'
            )
        }

        failure {
            emailext(
                subject: "❌ Jenkins Build Failed: ${JOB_NAME} #${BUILD_NUMBER}",
                body: """
                Hello Vigneshkumar,<br><br>
                The Jenkins build for <b>${JOB_NAME} #${BUILD_NUMBER}</b> has failed.<br><br>
                Check build logs here: <a href="${BUILD_URL}">${BUILD_URL}</a><br><br>
                Regards,<br>
                Jenkins CI/CD
                """,
                to: 'vigneshkumar5eee@gmail.com'
            )
        }
    }
}
