def repoName = ''
def branchName = ''

pipeline {
    agent any

    environment {
        ANSIBLE_CONFIG = '$PWD/ansible.cfg'
        ANSIBLE_SSH_ARGS = '-o ControlMaster=no -o ControlPersist=no -o ControlPath=none'
    }

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

        stage('Install Ansible collections dependencies') {
            when {
                expression {
                    return branchName == 'Dev'
                }
            }
            steps {
                script {
                    echo "Installing Ansible dependencies for repository: ${repoName} - branch: ${branchName}"
                    withCredentials([usernamePassword(credentialsId: 'NEXUS_CREDS', passwordVariable: 'NEXUS_PASS', usernameVariable: 'NEXUS_USER')]) {
                        sh '''
                            chmod +x ./requirements.sh
                            dos2unix ./requirements.sh
                            dos2unix collections.txt
                            ./requirements.sh ${NEXUS_USER} ${NEXUS_PASS} collections.txt
                        '''
                    }
                }
            }
        }

        stage('Run Ansible Playbook') {
            when {
                expression {
                    return branchName == 'Dev'
                }
            }
            steps {
                script {
                    echo "Running Ansible playbook for repository: ${repoName} - branch: ${branchName}"
                    
                }
            }
        }
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
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
    }
}