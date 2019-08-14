pipeline {
  agent {
    dockerfile true
  }
  stages {
    stage('verify') {
      steps {
        sh './install.sh -v'
      }
    }
    stage('install') {
      steps {
        sh './install.sh --profile all'
      }
    }
  }
}
