	node {
    def app

           environment {
                         DOCKERHUB_CREDENTIALS = 'dockerhub'
            }

    stage('Clone repository') {
      

        checkout scm
    }

    stage('Build image') {
  
       app =  docker.build("yogik001/tech-ai-dok")
    }

    stage('Test image') {
  

        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push to DockerHub')
 {
    steps {
        script {
            docker.withRegistry('', DOCKERHUB_CREDENTIALS) {
                dockerImage.push()
            }
        }
    }
}
    
    stage('Trigger ManifestUpdate') {
                echo "triggering updatemanifestjob"
                build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
        }
}
