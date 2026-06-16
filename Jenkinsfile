pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Gems') {
            steps {
                sh 'bundle install'
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh 'bundle exec fastlane unit_test'
            }
        }
    }
}
