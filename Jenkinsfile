//TODO 1.Swap username instances with an argument.

pipeline {
    agent any
    triggers{
        pollSCM('*/1 * * * *')
    }
    stages {
        stage('build-docker-image') {
            steps {
                buildImage()
            }
        }
        stage('deploy-to-dev') {
            steps {
                deploy("DEV")
            }
        }
        stage('test-on-dev') {
            steps {
                test("DEV")
            }
        }
        stage('deploy-to-stg') {
            steps {
               deploy("STG")
            }
        }
        stage('test-on-stg') {
            steps {
                test("STG")
            }
        }
        stage('deploy-to-prod') {
            steps {
                deploy("PROD")
            }
        }
        stage('test-on-prod') {
            steps {
                test("PROD")
            }
        }
    }
}


def buildImage(){
    echo "Building of Docker Image is starting.."
    sh "docker build -t oskarsstalgis/python-greetings-app:latest ."

    echo "Pushing image to Docker registry.."
    sh "docker push oskarsstalgis/python-greetings-app:latest"
}

def deploy(String enviroment){
    echo "Deploying Python microservice to ${enviroment} environment.."
    sh "docker pull oskarsstalgis/python-greetings-app:latest"
    sh "docker compose stop greetings-app-${enviroment.toLowerCase()}"
    sh "docker compose rm greetings-app-${enviroment.toLowerCase()}"
    sh "docker compose up -d greetings-app-${enviroment.toLowerCase()}"
}

def test(String enviroment){
    echo "API test executuon against node application on ${enviroment} environment.."
    sh "docker pull oskarsstalgis/api-tests:latest"
    def directory = pwd()
    sh "echo '${directory}'"
    sh "docker run --network=greetings-app-network-compose --rm oskarsstalgis/api-tests:latest run BOOKS BOOKS_DEV"
}
