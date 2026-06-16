pipeline {
    agent any

    environment {
        PATH = "${HOME}/.rbenv/shims:${HOME}/.rbenv/bin:/usr/local/bin:${env.PATH}"
    }

    stages {

        stage('Install') {
            steps {
                sh '''
                    eval "$(rbenv init -)"
                    ruby -v
                    gem install bundler:1.17.2
                    bundle _1.17.2_ install
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                    eval "$(rbenv init -)"
                    bundle _1.17.2_ exec fastlane unit_test
                '''
            }
        }
    }
}