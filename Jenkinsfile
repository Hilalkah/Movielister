pipeline {
    agent any

    stages {
        stage('Install Bundler deps') {
            steps {
                sh '''
                    export PATH="$HOME/.gem/ruby/3.*/bin:$PATH"
                    bundle install
                '''
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh '''
                    export PATH="$HOME/.gem/ruby/3.*/bin:$PATH"
                    bundle exec fastlane unit_test
                '''
            }
        }
    }
}
