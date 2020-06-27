def REPOSITORY_URI = "blackhawkee/demoapi"
def HELM_APP_NAME = "demoapi"
def HELM_CHART_DIRECTORY = "/var/lib/jenkins/workspace/demoapi_pipeline/helm"
pipeline { 
    agent any 
    options { timestamps () }
    stages {
        stage('Pull Standard Image') { 
            steps { 
                sh "echo 'Pulling ibmcom/ace image from docker hub'" 
                sh "docker pull ibmcom/ace:latest"
            }
        }
        stage('Build Custom Image'){
            steps {
                sh "echo 'Build custom image with bar file deployed to the standard image(ibmcom/ace)'" 
                //sh "docker build -t ${REPOSITORY_URI}:${BUILD_NUMBER} --pull=true /var/lib/jenkins/workspace/demoapi_pipeline" 
                sh "docker build -t ${REPOSITORY_URI}:latest --pull=true /var/lib/jenkins/workspace/demoapi_pipeline" 
            }
        }
        stage('Push Custom Image') {
            steps {
                sh "echo 'Pushing Custom image to Docker Hub...'"
                withCredentials([usernamePassword(credentialsId: 'd201a9e2-5b7d-466f-9fa3-bc95a96784be', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                  sh 'docker image ls'
                  //sh "docker push ${REPOSITORY_URI}:${BUILD_NUMBER}"
                  sh "docker push ${REPOSITORY_URI}:latest"
              }
            }
        }
        stage('Deploy Helm Chart'){
            steps {
                sh "echo 'Deploy Custom Image with Helm Chart'" 
		sh "echo 'Test Update'" 
                sh 'helm list'
                //sh "helm lint ./${HELM_CHART_DIRECTORY}"
                //sh "helm upgrade --wait --timeout 60 --set image.tag=${BUILD_NUMBER} ${HELM_APP_NAME} ./${HELM_CHART_DIRECTORY}"
                //sh "helm upgrade --wait --timeout 60 ${HELM_APP_NAME} ./${HELM_CHART_DIRECTORY}"
                //sh "helm install --name ${HELM_APP_NAME} ${HELM_CHART_DIRECTORY}"
                //sh "if [ ! -z "$helm list | grep ${HELM_APP_NAME}" ]; then helm upgrade ${HELM_APP_NAME} ${HELM_CHART_DIRECTORY} else helm install --name ${HELM_APP_NAME} ${HELM_CHART_DIRECTORY} fi"
                //sh 'if [ ! -z "$helm list | grep demoapi" ]; then helm upgrade ${HELM_APP_NAME} ${HELM_CHART_DIRECTORY} fi'
                //sh 'if [ -z "$helm list | grep demoapi" ]; then helm install --name demoapi ${HELM_CHART_DIRECTORY} fi'
                sh '''#!/bin/bash

                   if [ ! -z "$helm list | grep demoapi" ]; then
	                  helm upgrade demoapi /var/lib/jenkins/workspace/demoapi_pipeline/helm
	               else
	                  helm install --name demoapi /var/lib/jenkins/workspace/demoapi_pipeline/helm
	               fi
                   '''
                sh "helm list | grep ${HELM_APP_NAME}"
            }
        }
    }
}
