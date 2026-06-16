pipeline {
    agent any

    stages {
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
