pipeline {
  agent {
    docker { image 'debian:stretch-slim' }
  }
  stages {
    stage('update') {
      steps {
        sh 'apt update -y'
        sh 'apt install zsh vim curl -y'
      }
    }
    stage('verify') {
      steps {
        sh './install.sh -v'
      }
    }
    stage('Test') {
      steps {
        sh './install.sh --profile all'
      }
    }
  }
}
