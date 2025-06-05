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
        stage('deploy-prd') {
            steps {
                deploy("PRD")
            }
        }
        stage('test-prd') {
            steps {
                test("PRD")
            }
        }
    }
}


def buildImage(){
    echo "Building of node application is starting.."
    sh "docker build -t oskarsstalgis/api-tests:latest ."

    echo "Pushing img to Docker registry.."
    sh "docker push oskarsstalgis/api-tests:latest"
}

def deploy(String enviroment){
    echo "Deployment of node application on ${enviroment} environment.."
    sh "docker pull oskarsstalgis/sample-book-app"
    sh "docker compose stop sample-book-app-${enviroment.toLowerCase()}"
    sh "docker compose rm sample-book-app-${enviroment.toLowerCase()}"
    sh "docker compose up -d sample-book-app-${enviroment.toLowerCase()}"

}

def test(String environment){
    echo "API test executuon against node application on ${environment} environment.."
    sh "docker pull mtararujs/api-tests"
    def directory = pwd()
    sh "echo '${directory}'"
    sh "docker run --rm --network=sample-book-app-network-compose -v '${directory}':/api-tests/mochawesome-report/ mtararujs/api-tests run BOOKS BOOKS_${environment}"
    sh "ls"
    archiveArtifacts allowEmptyArchive: true, artifacts: 'mochawesome.json', followSymlinks: false
}
