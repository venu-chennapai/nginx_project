node{
    stage('Pull the nginx project file the GitHib'){
        git branch: 'main', url: 'https://github.com/venu-chennapai/nginx_project.git'
    }

    stage('Transfer the file from jenkins servers to ansible server via SSH '){
        sshagent(['ansible_server_credentials']) {
            sh '''
              scp -o StrictHostKeyChecking=no -r /var/lib/jenkins/workspace/nginx_project/* ubuntu@172.31.18.92:/home/ubuntu/nginx_project_ansible_home/
            '''
            sh '''
              ssh -o StrictHostKeyChecking=no ubuntu@172.31.18.92 "ls -l /home/ubuntu/nginx_project_ansible_home"
            '''
        }
    }

    stage('Build the docker image (nginx image) from ansible server'){
        sshagent(['ansible_server_credentials']){
            sh '''
              ssh -o StrictHostKeyChecking=no ubuntu@172.31.18.92 "cd /home/ubuntu/nginx_project_ansible_home && docker build -t nginx_app:latest ."
            '''
        }
    }
    stage('Tagging the image for builded by above docker file'){
        sshagent(['ansible_server_credentials']){
            sh '''
               ssh -o StrictHostKeyChecking=no ubuntu@172.31.18.92 "cd /home/ubuntu/nginx_project_ansible_home && docker tag nginx_app:latest venu8179/nginx_app:latest"
            '''
        }
    }
    stage('Builded image (nginx image) pusing into docker hub[ACCOUNT NAME : venuch8179]'){
        sshagent(['ansible_server_credentials']){
            withCredentials([string(credentialsId: 'docker_hub_passwd_nginx_prj', variable: 'docker_hub_password_nginx_prj')]){
                sh'''
                  ssh -o StrictHostKeyChecking=no ubuntu@172.31.18.92 "docker login -u venu8179 -p $docker_hub_password_nginx_prj  && docker push venu8179/nginx_app:latest"
                 '''
            }
        }
        
    }
    stage('Transfer files from Ansible to Kubernetes server') {
    sshagent(['ansible_server_credentials', 'kubernetes_server_credentials']) {
        sh '''
          ssh -A -o StrictHostKeyChecking=no ubuntu@172.31.18.92 \
          "scp -o StrictHostKeyChecking=no /home/ubuntu/nginx_project_ansible_home/* ubuntu@172.31.25.47:/home/ubuntu/nginx_project_kubernetes_home"
        '''
       }
   }

   stage('Kubernetes Deployment by using ansible'){
    sshagent(['ansible_server_credentials']) {
        sh '''
          ssh -o StrictHostKeyChecking=no ubuntu@172.31.18.92 \
          "cd /home/ubuntu/nginx_project_ansible_home && ansible-playbook ansible.yml"
        '''
    }
}

}