pipeline {
    agent any
    environment {
        registry = "vahiwe/capstone"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }
    stages {
         stage('Lint files') {
              steps {
                  sh 'make lint'
              }
         }
        //  stage('Building image') {
        //     steps{
        //         script {
        //             dockerImage = docker.build registry + ":$BUILD_NUMBER"
        //         }
        //     }
        // }
        // stage('Upload Image to Docker hub') {
        //     steps{
        //         script {
        //             docker.withRegistry( '', registryCredential ) {
        //                 dockerImage.push()
        //             }
        //         }
        //     }
        // }
        // stage('Remove Unused docker image') {
        //     steps{
        //         sh "docker rmi $registry:$BUILD_NUMBER"
        //     }
        // }
        stage('Configure and Build Kubernetes Cluster'){
            steps {
                withAWS(region:'us-west-2',credentials:'aws') {
                    sh 'aws eks --region us-west-2 update-kubeconfig --name udacity-project'                    
                }
            }
        }
        // stage('Configure and Build Kubernetes Cluster'){
        //     steps {
        //         withAWS(region:'us-west-2',credentials:'aws') {
        //             sh 'ansible-playbook ./playbooks/kubernetes-configure.yml'                    
        //         }
        //     }
        // }
        // stage('Deploy Updated Image to Cluster'){
        //     steps {
        //         sh '''
        //             export IMAGE="$registry:$BUILD_NUMBER"
        //             sed -ie "s~IMAGE~$IMAGE~g" kubernetes/container.yml
        //             sudo kubectl apply -f ./kubernetes
        //             '''
        //     }
        // }
    }
}