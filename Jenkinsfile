def repoName = ''
def branchName = ''

pipeline {
    agent any

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    stages {

        stage('Initialize variables') {
            steps {
                script {
                    repoName = env.GIT_URL?.tokenize('/').last()?.replace('.git', '')
                    branchName = env.GIT_BRANCH?.replaceFirst(/^origin\//, '')
                }
            }
        }

        stage('Checkout Repositories') {
            when {
                anyOf {
                    branch 'PR-*'
                    expression {
                        return branchName == 'Dev'
                    }
                }
            }
            steps {
                script {
                    echo "Checking out the source code from the repository: ${repoName} - branch: ${branchName}"
                    dir('ansible-playbooks') {
                        checkout scm
                    }
                }
            }
        }

        stage('Set up ansible environment variables') {
            when {
                anyOf {
                    branch 'PR-*'
                    expression {
                        return branchName == 'Dev'
                    }
                }
            }
            steps {
                script {
                    echo "Setting up Ansible environment variables for repository: ${repoName} - branch: ${branchName}"
                    // Add any environment variable setup needed for Ansible here
                    sh 'export ANSIBLE_CONFIG=$PWD/ansible.cfg'
                    sh 'export ANSIBLE_SSH_ARGS="-o ControlMaster=no -o ControlPersist=no -o ControlPath=none"'
                }
            }
            
        }

        stage('Install Ansible collections dependencies') {
            when {
                anyOf {
                    branch 'PR-*'
                    expression {
                        return branchName == 'Dev'
                    }
                }
            }
            steps {
                script {
                    echo "Installing Ansible dependencies for repository: ${repoName} - branch: ${branchName}"
                    
                }
            }
        }

        stage('Run Ansible Playbook') {
            when {
                anyOf {
                    branch 'PR-*'
                    expression {
                        return branchName == 'Dev'
                    }
                }
            }
            steps {
                script {
                    echo "Running Ansible playbook for repository: ${repoName} - branch: ${branchName}"
                    
                }
            }
        }

        // Additional stages can be added here
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
        aborted {
            echo 'Pipeline was aborted.'
        }
    }
}