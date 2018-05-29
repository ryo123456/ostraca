def jenkins_path= "/var/lib/jenkins"
def tf_path = "${jenkins_path}/terraform"
def terraform = "/usr/local/bin/terraform"
def ansible_path = "${jenkins_path}/ansible" 

node {
 
    stage('scm'){
        checkout scm
    }

    stage('terraform'){
        dir("${tf_path}"){
            sh "${terraform} state show aws_lb_target_group_attachment.server1 | grep target_group_arn | grep Green > state.txt"
            sh "sh aws.sh"
        }
    }

    stage('wget'){
        dir("${ansible_path}"){
            sh "rm -fr ostraca.yml"
            sh "wget https://github.com/ryo123456/ostraca/raw/master/playbook/ostraca.yml"
            sh "rm -fr index.html"
            sh "wget https://github.com/ryo123456/ostraca/raw/master/sources/index.html"
            sh "rm -fr logo.png"
            sh "wget https://github.com/ryo123456/ostraca/raw/master/sources/logo.png"
        }
    }

    stage('ansible'){
        dir("${ansible_path}"){
            sh "ansible-playbook -i hosts ostraca.yml --private-key=~/.ssh/devops.pem"
        }
    }

}