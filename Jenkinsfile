pipeline {
    agent any

    stages {

        stage('Install') {
            steps {
                sh '''
                    gem install bundler -v 2.4.22
                    bundle _2.4.22_ install
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                    bundle _2.4.22_ exec fastlane unit_test
                '''
            }
        }
    }
}
