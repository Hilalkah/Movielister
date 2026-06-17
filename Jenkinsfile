pipeline {
    agent any

    environment {
        PATH = "${HOME}/.rbenv/shims:${HOME}/.rbenv/bin:/usr/local/bin:${env.PATH}"
        LANG = "en_US.UTF-8"
        LC_ALL = "en_US.UTF-8"
        LANGUAGE = "en_US.UTF-8"
    }

    stages {

        stage('Install') {
            steps {
                githubNotify status: 'PENDING',
                             description: 'Tests are running...',
                             credentialsId: 'github-token',
                             account: 'Hilalkah',
                             repo: 'Movielister',
                             sha: "${GIT_COMMIT}"
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
    }

    post {
        success {
            githubNotify status: 'SUCCESS',
                         description: 'Tests passed!',
                         credentialsId: 'github-token',
                         account: 'Hilalkah',
                         repo: 'Movielister',
                         sha: "${GIT_COMMIT}"
        }
        failure {
            githubNotify status: 'FAILURE',
                         description: 'Tests failed!',
                         credentialsId: 'github-token',
                         account: 'Hilalkah',
                         repo: 'Movielister',
                         sha: "${GIT_COMMIT}"
        }
    }
}