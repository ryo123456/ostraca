#!/bin/sh

/usr/local/bin/terraform state show aws_lb_target_group_attachment.server1 | grep target_group_arn | grep Green > state.txt

if cat state.txt | grep Green
then 
   /usr/local/bin/terraform destroy -target="aws_instance.server1" -auto-approve -var "if =server1"
   /usr/local/bin/terraform plan -var "if =server1"
   /usr/local/bin/terraform apply -auto-approve -var "if =server1"
   echo [server] >/var/lib/jenkins/ansible/hosts
   /usr/local/bin/terraform state show  aws_instance.server1 | grep public_dns | awk '{print $3}' >> /var/lib/jenkins/ansible/hosts

else
   /usr/local/bin/terraform destroy -target="aws_instance.server2" -auto-approve -var "if =server2"
   /usr/local/bin/terraform plan -var "if =server2"
   /usr/local/bin/terraform apply -auto-approve -var "if =server2"
   echo [server] >/var/lib/jenkins/ansible/hosts
   /usr/local/bin/terraform state show  aws_instance.server2 | grep public_dns | awk '{print $3}' >> /var/lib/jenkins/ansible/hosts
fi
