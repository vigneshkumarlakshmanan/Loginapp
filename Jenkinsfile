pipeline {
    agent any
     tools {
        maven 'Maven' //this is the tool for  build the project need to the name as configuration tool name
        jdk 'java-17'  //java home environment
    }
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
