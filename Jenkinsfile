pipeline {
    environment {
       registry = "natu123/cardb"
              registryCredentials = "dockerhub_id"
              dockerImage = ""
       }
    agent any
    stages {
        stage('Source Repositories Checkout') {
            steps {
                dir("lbg-car-backend") {
                    git url: "https://github.com/QA-Instructor/lbg-car-spring-completed.git", branch: "main"
                }
                dir("lbg-car-frontend") {
                    git url: "https://github.com/QA-Instructor/lbg-car-react-completed.git", branch: "main"
                }
            }
        }
        stage ('Docker Image Build'){
            steps{
                script {
                    dockerImage = docker.build(registry)
                }
            }
        }
        stage ("Push Up To Docker Hub"){
            steps {
                script {
                    docker.withRegistry('', registryCredentials) {
                        dockerImage.push("${env.BUILD_NUMBER}")
                        dockerImage.push("latest")
                    }
                }
            }
        }

        stage ("Clean-Up"){
            steps {
                script {
                    sh 'docker image prune --all --force --filter "until=48h"'
                       }
            }
        }
    }
}
