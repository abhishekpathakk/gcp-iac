pipeline {
  agent any

  environment {
    PROJECT_ID = "solid-muse-458612-b7"
    REGION = "us-central1"
    ZONE = "us-central1-a"
    CLUSTER = "hello-cluster"
    IMAGE_NAME = "gcr.io/solid-muse-458612-b7/hello-app:v1"
  }

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
            sh """
              export GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_CRED
              terraform plan -lock=false \
                -var='credentials_path=$GOOGLE_CRED' \
                -var='project=${PROJECT_ID}' \
                -var='region=${REGION}' \
                -var='zone=${ZONE}'
            """
          }
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        withCredentials([file(credentialsId: 'gcp-sa-json', variable: 'GOOGLE_CRED')]) {
          dir('terraform') {
            sh """
              export GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_CRED
              terraform apply -auto-approve \
                -var='credentials_path=$GOOGLE_CRED' \
                -var='project=${PROJECT_ID}' \
                -var='region=${REGION}' \
                -var='zone=${ZONE}'
            """
          }
        }
      }
    }

    stage('Docker Build & Push') {
      steps {
        withCredentials([file(credentialsId: 'gcp-sa-json', variable: 'GOOGLE_CRED')]) {
          sh '''
            export GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_CRED
            gcloud auth activate-service-account --key-file=$GOOGLE_CRED
            gcloud auth configure-docker
            docker build -t gcr.io/solid-muse-458612-b7/hello-app:v1 .
            docker push gcr.io/solid-muse-458612-b7/hello-app:v1
          '''
        }
      }
    }

    stage('GKE Deploy') {
      steps {
        withCredentials([file(credentialsId: 'gcp-sa-json', variable: 'GOOGLE_CRED')]) {
          sh '''
            export GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_CRED
            gcloud auth activate-service-account --key-file=$GOOGLE_CRED
            gcloud container clusters get-credentials hello-cluster --zone=us-central1-a --project=solid-muse-458612-b7
            kubectl apply -f hello-deployment.yaml
            kubectl apply -f hello-service.yaml
          '''
        }
      }
    }
  }
}
