pipeline {
  agent any

  stages {
    stage('Checkout Code') {
      steps {
        checkout scm
      }
    }

    stage('Terraform Init') {
      steps {
        withCredentials([file(credentialsId: 'gcp-sa-json', variable: 'GOOGLE_CRED')]) {
          dir('terraform') {
            sh '''
              export GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_CRED
              terraform init
            '''
          }
        }
      }
    }

    stage('Terraform Validate') {
      steps {
        withCredentials([file(credentialsId: 'gcp-sa-json', variable: 'GOOGLE_CRED')]) {
          dir('terraform') {
            sh '''
              export GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_CRED
              terraform validate
            '''
          }
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        withCredentials([file(credentialsId: 'gcp-sa-json', variable: 'GOOGLE_CRED')]) {
          dir('terraform') {
            sh '''
              export GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_CRED
              terraform plan -lock=false
            '''
          }
        }
      }
    }
  }
}