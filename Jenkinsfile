pipeline {
  agent any

    stages {
      stage('check files') {
        steps {
          sh './install.sh -v'
        }
      }
      stage('build') {
        steps {
          sh 'echo "a" | sudo -S docker build -t dotfiles .'
        }
      }
    }

  post {
    success {
      telegramSend 'i3wm Build: Passed'
    }
    failure {
      telegramSend 'i3wm Build: Failed'
    }
    aborted {
      telegramSend 'i3wm Build: Aborted'
    }
  }
}

