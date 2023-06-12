Transversal services 

- VPC
- ECS Cluster
- modules


```bash
terraform plan -var-file="env/qa/qa.tfvars"
terraform apply -auto-approve
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 670414101519.dkr.ecr.us-east-1.amazonaws.com
docker push 670414101519.dkr.ecr.us-east-1.amazonaws.com/ecs-kinesis-timestream-data-producer-qa-ecr:latest
```