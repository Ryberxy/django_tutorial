pipeline {
    agent none

    stages {
        stage("Build and Test the Project") {
            agent {
                docker { 
                    image 'ryberxy/django_polls-test:v3'
                    args '-u root:root'
                }
            }
            steps {
                git branch: 'master', url: 'https://github.com/Ryberxy/django_tutorial.git'

                sh 'pip install -r requirements.txt'

                sh 'python3 manage.py test polls'
            }
        }

        stage("Build and Push Docker Image") {
            agent any
            environment {
                DOCKER_IMAGE = "ryberxy/django_polls:latest"
            }
            steps {
                git branch: 'master', url: 'https://github.com/Ryberxy/django_tutorial.git'

                script {
                    docker.withRegistry('', 'docker-hub-credentials') {
                        def image = docker.build(DOCKER_IMAGE)
                        image.push()
                    }

                    sh "docker rmi ${DOCKER_IMAGE}"
                }
            }
        }
    }

    post {
        always {
            mail to: 'maquinon447@gmail.com',
                 subject: "Resultado Pipeline: ${currentBuild.fullDisplayName}",
                 body: "El pipeline ha terminado. Estado: ${currentBuild.currentResult}"
        }
    }
}
