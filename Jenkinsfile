pipeline {
    agent any

    environment {
        PATH = "${HOME}/.rbenv/shims:${HOME}/.rbenv/bin:/usr/local/bin:${env.PATH}"
        LANG = "en_US.UTF-8"
        LC_ALL = "en_US.UTF-8"
        LANGUAGE = "en_US.UTF-8"
        GIT_COMMIT_MSG = sh(script: 'git log -1 --pretty=%B', returnStdout: true).trim()
    }

    stages {

        stage('Install') {
            steps {
                sh '''
                    eval "$(rbenv init -)"
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

        stage('Distribute') {
            steps {
                sh '''
                    eval "$(rbenv init -)"
                    bundle _1.17.2_ exec fastlane distribute
                '''
            }
        }
    }
}