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
        stage('deploy-dev') {
            steps {
                deploy("DEV")
            }
        }
        stage('test-dev') {
            steps {
                test("DEV")
            }
        }
        stage('deploy-stg') {
            steps {
               deploy("STG")
            }
        }
        stage('test-stg') {
            steps {
                test("STG")
            }
        }
        stage('deploy-prod') {
            steps {
                deploy("PROD")
            }
        }
        stage('test-pr0d') {
            steps {
                test("PROD")
            }
        }
    }
}


def buildImage(){
    echo "Building of node application is starting.."
    sh "docker build -t oskarsstalgis/python-greetings-app:latest ."

    echo "Pushing img to Docker registry.."
    sh "docker push oskarsstalgis/python-greetings-app:latest"
}

def deploy(String enviroment){
    echo "Deployment of node application on ${enviroment} environment.."
    sh "docker pull oskarsstalgis/python-greetings-app:latest"
    sh "docker compose stop greetings-app-${enviroment.toLowerCase()}"
    sh "docker compose rm greetings-app-${enviroment.toLowerCase()}"
    sh "docker compose up -d greetings-app-${enviroment.toLowerCase()}"

}

def test(String environment){
    echo "API test executuon against node application on ${environment} environment.."
    sh "docker pull oskarsstalgis/api-tests:latest"
    def directory = pwd()
    sh "echo '${directory}'"
    sh "docker run --network=host --rm oskarsstalgis/api-tests:latest run greetings greetings_${enviroment.toLowerCase()} "
   
}
