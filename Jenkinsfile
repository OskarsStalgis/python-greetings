//TODO 1.Swap username instances with an argument.

pipeline {
    agent any
    environment{
        DOCKER_USR='oskarsstalgis'
    }
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

// def docker_usr="oskarsstalgis"

def buildImage(){
    echo "Building of Docker Image is starting.."
    sh "docker build -t ${DOCKER_USR}/python-greetings-app:latest ."

    echo "Pushing image to Docker registry.."
    sh "docker push ${DOCKER_USR}/python-greetings-app:latest"
}

def deploy(String enviroment){
    echo "Deploying Python microservice to ${enviroment} environment.."
    sh "docker pull ${DOCKER_USR}/python-greetings-app:latest"
    sh "docker compose stop greetings-app-${enviroment.toLowerCase()}"
    sh "docker compose rm greetings-app-${enviroment.toLowerCase()}"
    sh "docker compose up -d greetings-app-${enviroment.toLowerCase()}"
}

def test(String enviroment){
    echo "API test executuon against node application on ${enviroment} environment.."
    sh "docker pull ${DOCKER_USR}/api-tests:latest"
    def direcory = pwd()
    sh "docker run --rm --network=host ${DOCKER_USR}/api-tests:latest run greetings greetings_${enviroment.toLowerCase()}"
    sh "ls"
}
