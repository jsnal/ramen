pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
      args '-u jenkins:jenkins'
    }
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
