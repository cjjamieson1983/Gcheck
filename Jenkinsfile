pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-2'
        TF_IN_AUTOMATION   = 'true'
    }

    triggers {
        githubPush()
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'jenkins-aws-access'
                ]]) {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'jenkins-aws-access'
                ]]) {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'jenkins-aws-access'
                ]]) {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Optional Destroy') {
            steps {
                input message: 'Destroy infrastructure?', ok: 'Yes, destroy it!'
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'jenkins-aws-access'
                ]]) {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }
}
