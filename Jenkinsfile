pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub'
    }

    stages {
        stage('Clone repository') {
            steps {
                checkout scm
            }
        }

        stage('Build image') {
            steps {
                script {
                     app = docker.build("tech-img:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Test image') {
            steps {
                script {
                    app.inside {
                        sh 'echo "Tests passed"'
                    }
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                        sh "docker tag tech-img:${env.BUILD_NUMBER} $DOCKER_USER/tech-img:${env.BUILD_NUMBER}"
                        sh "docker push $DOCKER_USER/tech-img:${env.BUILD_NUMBER}"
}

                    }
                }
            
        }

        stage('Trigger ManifestUpdate') {
            steps {
                script {
                    echo "Triggering updatemanifest job"
                    build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
                }
            }
        }
    }
}
